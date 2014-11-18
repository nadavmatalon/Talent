class ApplicationController < ActionController::Base
#   Prevent CSRF attacks by raising an exception.
#   For APIs, you may want to use :null_session instead.
#   protect_from_forgery with: :exception
    protect_from_forgery with: :null_session

    before_filter :configure_permitted_parameters, if: :devise_controller?

    before_filter :sign_out_all_users, if: Proc.new { current_client && current_developer }


    private

    def after_sign_up_path_for(resource)
        
        if current_client
            client_dashboard_path(resource)
        elsif current_developer
            developer_dashboard_path(resource)
        end
    end

    def after_sign_in_path_for(resource)
        if current_client
            client_dashboard_path(resource)
        elsif current_developer
            developer_dashboard_path(resource)
        end
    end

    def sign_out_all_users
        sign_out current_client
        sign_out current_developer
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |user| user.permit(:id, :email, :password, :password_confirmation) }
        devise_parameter_sanitizer.for(:sign_in) { |user| user.permit(:id, :email, :password, :remember_me) }
        devise_parameter_sanitizer.for(:client_update) { |user| user.permit(:id, :email, :password, :password_confirmation) }
        devise_parameter_sanitizer.for(:developer_update) { |user| user.permit(:id, :email, :password, :password_confirmation, skill: :name) }
        devise_parameter_sanitizer.for(:password_new) { |user| user.permit(:id, :email, :password, :password_confirmation) }
        devise_parameter_sanitizer.for(:password_edit) { |user| user.permit(:id, :email, :password, :password_confirmation) }
    end

end

