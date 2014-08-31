class ApplicationController < ActionController::Base
#   Prevent CSRF attacks by raising an exception.
#   For APIs, you may want to use :null_session instead.
#   protect_from_forgery with: :exception
    protect_from_forgery with: :null_session

    before_filter :configure_permitted_parameters, if: :devise_controller?


    private

    def after_sign_up_path_for(resource)
        if current_client
            client_dashboard_path(current_client)
        elsif current_developer
            developer_dashboard_path(current_developer)
        end
    end

    def after_sign_in_path_for(resource)
        if current_client
            client_dashboard_path(current_client)
        elsif current_developer
            developer_dashboard_path(current_developer)
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:id, :email, :password, :remember_me) }
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:id, :email, :password, :password_confirmation, skill: :name) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:id, :email, :password, :password_confirmation, skill: :name) }
        devise_parameter_sanitizer.for(:password_edit) { |u| u.permit(:id, :email, :password, :password_confirmation, :current_password) }
        devise_parameter_sanitizer.for(:password_new) { |u| u.permit(:id, :email, :password, :password_confirmation, :current_password) }
    end

end

