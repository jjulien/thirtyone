class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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
    @user = User.new(user_params)
    @user.password = Devise.friendly_token.first(8)
    respond_to do |format|
      if @user.save
        @user.send_new_account_instructions
        format.html {
          message = ['User was successfully created']
          if Rails.env.development?
            link_to_edit_password = edit_password_url(@user, reset_password_token: @user.reset_password_token)
            message << 'Since you are in the development environment and email is likely not possible,'
            message << "the link being sent to #{@user.email} for setting their password is:\n"
            message << view_context.link_to(link_to_edit_password, link_to_edit_password)
            message << ''
            message << 'You will need to logout before you can use this link to set the users password'
          end
          redirect_to @user, notice: message
        }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end

end
