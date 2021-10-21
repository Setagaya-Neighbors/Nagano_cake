class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_ruby,:first_name_ruby,:postal_code,:address,:phone_number,:encrypted_password])
  end
end
