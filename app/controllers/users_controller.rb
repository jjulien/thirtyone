class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

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
    @user.update!(user_params)

    conditionally_notify_email

    conditionally_re_login_user

    respond_to do |format|
      if @user.valid? && @user.errors.empty?
        # TODO: Why does this notice not show up?
        format.html { redirect_to edit_user_path(@user.id), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

    # TODO: Rescue errors
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to users_url unless @user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # Notifies the user by email if they opted to change their email
  def conditionally_notify_email
    if user_params[:email] != @user.email
      @user.send_confirmation_email
      flash.notice = 'Email successfully updated. Check your new e-mail for instructions to confirm'
    end
  end

  # Logs the user back in if they opted to change their password
  def conditionally_re_login_user
    if user_params[:password] && user_params[:password_confirmation]
      sign_in @user, :bypass => true
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
