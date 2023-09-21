class ApplicationController < ActionController::Base

  before_action :check_for_lockup
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    photos_path(current_user) 
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    err_message = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    render json: { message: err_message }, status: :unauthorized
  end
end
