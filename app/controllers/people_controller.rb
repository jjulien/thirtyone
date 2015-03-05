class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /people
  # GET /people.json
  def index
    @people = Person.all
    @new_person = Person.new
    @all_states = State.all
    #@new_household = Household.new
    #@new_household.address = Address.new
    #@new_household.address.state = State.new
  end

  # GET /people/search
  # GET /people/search.json
  def search
    rowlimit = params[:rowlimit] || 10
    if (params[:search])
      search_keys = JSON.parse(params[:search]).to_a
      search_keys[0] = '' if search_keys.length == 0
      firstname_key = (search_keys.first || '') + '%'
      lastname_key = (search_keys.last || '') + '%'

      sql_conditional = "OR"
      sql_conditional = "AND" if search_keys.length > 1

      @people = Person.where("firstname LIKE ? #{sql_conditional} lastname LIKE ?", firstname_key, lastname_key).first(rowlimit.to_i)
      @new_person = Person.new
      respond_to do |format|
        format.html {
          if params[:ajax]
            render :partial => 'search_results'
          else
            @search_string = ''
            search_keys.each do |key|
              @search_string << ' ' if not @search_string.empty?
              @search_string << key
            end
            render :action => 'index'
          end
        }
        format.json { render action: 'index.json' }
      end
    else
      @people = Person.all
      @new_person = Person.new
      respond_to do |format|
        format.html {
          if params[:ajax]
            render :partial => 'search_results'
          else
            render :action => 'index'
          end
        }
        format.json { render action: 'index.json' }
      end
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    authorize @person
    @household = @person.household
  end

  # GET /people/new
  def new
    @person = Person.new
    @new_household = Household.new
    if params[:search]
      @person.firstname, @person.lastname = params[:search].split(' ', 2)
    end
    @roles = Role.all
  end

  # GET /people/1/edit
  def edit
    @household = Household.find(@person.household_id);
    @roles = Role.all
  end

  # POST /people
  # POST /people.json
  def create
    #authorize Person
    @person = Person.new(person_params)
    if params[:person][:household_id]
      @person.household_id = params[:person][:household_id]
      errors = true if not @person.save
    else
      household = Household.new
      household.address = Address.new(address_params)
      household.address.state = State.find(params[:state][:id])
      @person.household = household
      if @person.save
        household.person = @person
        household.save
      else
        errors = true
      end
    end
    if not errors and params[:create_user] = 'yes'
      if not @person.user
        @person.user = User.new({email: params[:person][:email], password: Devise.friendly_token.first(8)})

        params[:roles].each do |role_id|
          @person.user.roles.push(Role.find(role_id))
        end
      end
    end

    respond_to do |format|
      if not errors
        search_keys = JSON.generate([@person.firstname, @person.lastname])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @person }
      else
        format.html { render action: 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    if params[:person][:household_id]
      @person.household_id = params[:person][:household_id]
      errors = true if not @person.save
    else
      household = Household.new
      household.address = Address.new(address_params)
      household.address.state = State.find(params[:state][:id])
      @person.household = household
      if @person.save
        household.person = @person
        household.save
      else
        errors = true
      end
    end
    if not errors and params[:create_user] = 'yes'
      if not @person.user
        @person.user = User.new({email: params[:person][:email], password: Devise.friendly_token.first(8)})

        params[:roles].each do |role_id|
          @person.user.roles.push(Role.find(role_id))
        end
      end
    end

    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
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
  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    params.require(:person).permit(:firstname, :lastname, :phone, :household_id)
  end

  def address_params
    params.require(:address).permit(:line1, :line2, :city, :state, :zip, :state_id)
  end
end
