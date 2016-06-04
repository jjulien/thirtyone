class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :init

  def init
    @errors = []
    authorize_person
  end

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
    @new_person = Person.new
    @all_states = State.all
  end

  # GET /people/search
  # GET /people/search.json
  def search
    @people = PeopleSearch.search(params)
    respond_to do |format|
      format.html {
        if params[:ajax]
          render partial: 'search_results'
        else
          @new_person = Person.new
          @search_string = params[:search] ? params[:search].join(" ") : ""
          render action: 'index'
        end
      }
      format.json { render action: 'index.json' }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @household = @person.household
    @roles = Role.all
  end

  # GET /people/new
  def new
    @person = Person.new
    @all_states = State.all
    @new_household = Household.new
    if params[:search]
      @person.firstname, @person.lastname = params[:search].split(' ', 2)
    end

    if params[:household_id]
      @person.household = Household.find_by(id: params[:household_id])
    elsif params[:household_data]
      household_data = JSON.load(params[:household_data])
      address_data = household_data["address"]
      @new_household.address = Address.new(address_data)
    end

    @person.household ||= @new_household
    set_necessary_view_data
  end

  # GET /people/1/edit
  def edit
    @household = @person.household
    @all_states = State.all
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new
    manage_create_or_update
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    manage_create_or_update(true)
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  private

  def update_person
    errors = []
    @person.transaction do
      begin
        if params[:person][:household_id]
          @person.household_id = params[:person][:household_id]
          @person.save
        else
          household = Household.new
          begin
            household.address = Address.new(address_params)
            household.address.state = State.find(params[:state][:id])
          rescue ActionController::ParameterMissing => e
            # No need to do anything, we just want to catch this error so it doesnt' bubble up
            # the validation of @person will fail since @person.household.address isn't present
            # We will present the error message to the use based on the model validation failuer
          end
          @person.household = household
          if @person.save
            household.person = @person
            household.save
          end
        end
        if params[:create_user] == 'yes'
          if params[:person][:email].blank?
            @person.add_custom_error(:email, 'is required when the person is also allowed to login')
            # If email is blank, we will have a harsher error if we try to create a new user later
            raise ActiveRecord::Rollback
          elsif not params[:person][:email] =~ Devise.email_regexp
            @person.add_custom_error(:email, 'is not valid')
          end
          if not @person.user
            new_user = User.new({email: params[:person][:email], password: Devise.friendly_token.first(8)})
            new_user.confirm_email_change
            new_user.roles.append(Role.default_role)
            if new_user.valid?
              @person.user = new_user
            else
              errors += new_user.errors.full_messages
            end
          else
            # We need to make sure the users email is always in-sync with the persons email
            # ideally we'd just store this in one place but devise requires email to be in the
            # users table.  We might also at one point want to allows users to have a different
            # email that they use for being a pantry guest and a pantry user
            @person.user.email = params[:person][:email];
          end
        else
          if @person.user
            @person.user.delete
          end
        end
        @person.update(person_params)
        if not @person.user.nil? and @person.user.should_send_confirmation_email?
          @person.user.send_confirmation_email
        end

        # We need to raise a rollback exception if we don't validate
        # It will get caught by the broader Exception rescue and then get re-escalated
        # which may seem redunant, and it is, but we still need the broader Exception
        # rescue in case something happens before we get to the validation code and
        # an ActiveRecord::Rollback exception is called.
        if not @person.valid?
          raise ActiveRecord::Rollback
        end
      rescue ActiveRecord::Rollback
        # We need to catch this so that we don't end up in the unknown error rescue
        # which is for everything except a rollback.  A rollback means we saw a problem
        # and have populated the errors array and intend to tell the user what happened
        #
        # We still have to actually raise ActiveRecord::Rollback though, so that Rails will
        # catch it and perform the rollback.
        raise ActiveRecord::Rollback
      rescue Exception => e
        logger.error e.message
        logger.error e.backtrace.join("\n")
        errors << 'An unknown error occurred: ' + e.message
        raise ActiveRecord::Rollback
      end
    end
    return errors
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find_by(id: params[:id])
    @all_states = State.all
    redirect_to action: 'index' unless @person
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    params.require(:person).permit(:firstname, :lastname, :phone, :phone_ext, :household_id, :email)
  end

  def address_params
    params.require(:address).permit(:line1, :line2, :city, :state, :zip, :state_id)
  end

  def authorize_person
    @person ? (authorize @person) : (authorize :person)
  end

  def set_necessary_view_data
    @selected_roles = [Role.default_role]
    @roles = Role.all
  end

  def manage_create_or_update(is_update = false)
    @person ||= Person.new
    psv = PeopleSubmissionValidator.new(params)

    respond_to do |format|
      if psv.process(@person)
        @person.user.send_new_account_instructions unless(@person.user.nil? || is_update)
        url = @person.user if psv.is_new_user
        url ||= params[:redirect_to_url] || @person
        msg = is_update ? "updated" : "created"
        format.html { redirect_to url, notice: "Person was successfully #{msg}." }
        if is_update
          format.json { head :no_content }
        else
          format.json { render action: "show", status: :created, location: @person }
        end
      else
        set_necessary_view_data
        format.html { render action: is_update ? "edit" : "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
end
