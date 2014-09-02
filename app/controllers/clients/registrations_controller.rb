class Clients::RegistrationsController < Devise::RegistrationsController

    def new
        @client = Client.new
    end

    def create
        sign_up_params = devise_parameter_sanitizer.sanitize(:sign_up)
        @client = Client.new sign_up_params
        if @client.save
            sign_in @client
            flash[:notice] = 'Signed up successfully'
            redirect_to client_dashboard_path(@client)
        else
            render 'new'
        end
    end

    def update
        update_params = devise_parameter_sanitizer.sanitize(:client_update)
        if update_params[:password].blank?
            update_params.delete('password')
            update_params.delete('password_confirmation')
        end
        @client = Client.find_by(id: current_client.id)
        if @client.update_attributes update_params
            sign_in @client, bypass: true
            flash[:notice] = 'Profile successfully updated'
            # redirect to show clinet profile 
            redirect_to client_path(@client)
            # redirect to client dashboard 
            # redirect_to client_dashboard_path(@client)
        else
            render 'edit'
        end
    end

end

