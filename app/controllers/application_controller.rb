class ApplicationController < ActionController::Base
    before_action :update_allowed_parameters, if: :devise_controller?
    before_action :authenticate_user!
    
    protected
    def update_allowed_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :first_name, :last_name, :email, :password, :current_password)}
      end
end
