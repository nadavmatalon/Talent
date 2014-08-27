class Clients::RegistrationsController < Devise::RegistrationsController
  
  def update
    # For Rails 4
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    # For Rails 3
    # account_update_params = params[:client]

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?      
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    if account_update_params[:email].blank?      
      account_update_params.delete("email")
    end

    if account_update_params[:current_password].blank?      
      account_update_params.delete("current_password")
    end

    @client = Client.find(current_client.id)
    if @client.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      # sign_in @client, bypass: true
      sign_in_and_redirect @client,  bypass: true
    else
      render "edit"
    end
  end

  protected

  def after_update_path_for(resource)
    client_path(resource)
  end
end