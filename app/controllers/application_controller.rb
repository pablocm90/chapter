class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_registration!

  helper_method :current_user, :current_author
  attr_reader :current_user, :current_author

  def current_user
    @current_user ||= current_registration.try(:user)
  end

  def current_author
    @current_author ||= current_registration.try(:author)
  end





  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    # For additional in app/views/devise/registrations/edit.html.erb
    # devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
