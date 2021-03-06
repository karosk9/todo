class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :pundishing_user

  protected

  def pundishing_user
    flash[:error] = 'You have no permission to this action!'
    redirect_back(fallback_location: root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name avatar avatar_cache remove_avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name avatar avatar_cache remove_avatar])
  end

  def after_sign_in_path_for(_resource)
    if current_user.first_name? && current_user.last_name?
      '/'
    else
      edit_user_registration_path(current_user)
    end
  end
end
