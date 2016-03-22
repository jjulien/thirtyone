class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @people = Person.includes(:user).where.not(users: {id: nil})
    @new_person = Person.new
    @all_states = State.all
    render 'people/index'
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @back_url = users_path
  end

  # GET /users/new
  def new
    @user = User.new
    @back_url = users_path
  end

  # GET /users/1/edit
  def edit
    @back_url = user_path(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    # Wiped this method because user management is being handled through the person controller
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {
          flash[:notice] = 'User was successfully updated.'
          redirect_to action: 'index'
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_id(id: params[:id])
    redirect_to users_url unless @user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email)
  end

end
