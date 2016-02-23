class UsersController < ApplicationController
  # GET /user
  # GET /user.json
  def index
    @people = Person.includes(:user).where.not(users: {id: nil})
    @new_person = Person.new
    @all_states = State.all
    render 'people/index'
  end

  # GET /user/1/edit
  def edit
  end

  # PATCH/PUT /user/1
  # PATCH/PUT /user/1.json
  def update
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to users_url unless @user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email)
  end
end
