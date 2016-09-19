class ApplicationController < ActionController::Base
  include Pundit
  include ApplicationHelper

  def authenticate_user!(opts={})
    super
    if not admin_setup_complete? and not requested_admin_setup_page?
      session['admin_setup_redirect_to'] = request.original_url
      redirect_to adminsetup_url
    end
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = I18n.t "pundit.#{policy_name}.#{exception.query}", default: 'You cannot perform this action.'
    redirect_to(request.referrer || root_path)
  end

end
