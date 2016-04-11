class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :cancel_pending_email_change, :send_confirmation_email, :confirm_email_change]
  before_action :authenticate_user!, except: [:confirm_email_change]
  before_action :authorize_person

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
    @roles = Role.all
    if @person.user
      @selected_roles = @person.user.roles
    else
      @selected_roles = [Role.default_role]
    end
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

  # This is an AJAX only method, there is no page to be displayed.  It just invokes an action.
  def send_confirmation_email
    if !@person.user.nil? && @person.user.has_pending_email_change?
      @person.user.send_confirmation_email
    end
    render nothing: true, status: 200, content_type: 'text/html'
  end

  # This is an AJAX only method, there is no page to be displayed.  It just invokes an action.
  def cancel_pending_email_change
    unless @person.user.nil?
      @person.user.cancel_pending_email_change
      @person.save
    end
    render nothing: true, status: 200, content_type: 'text/html'
  end

  # This page does not require authentication
  def confirm_email_change
    view_to_render = 'users/email/invalid_token'
    user = @person.user

    if !user.nil? && user.has_pending_email_change?
      if params[:confirmation_token] == user.reset_email_token
        success = user.confirm_email_change
        @errors = [user.errors.full_messages] unless success
      end
      view_to_render = 'users/email/confirm_email_change'
    end
    render view_to_render
  end

  def redirect_to_url
    if params[:redirect_to_url]
      return params[:redirect_to_url]
    end
  end
  helper_method :redirect_to_url

  private

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
