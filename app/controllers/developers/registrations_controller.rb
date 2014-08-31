class Developers::RegistrationsController < Devise::RegistrationsController

    def edit
        @skills = Skill.all
    end

    def update

        account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

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

        @developer = Developer.find(current_developer.id)

        # @marked_skills = []
        # Skill.all.each do |skill|           
        #     @marked_skills << skill if params[skill.name.downcase] == "on"              
        # end

        if @developer.update_attributes(account_update_params)
            @developer.skills.clear
            Skill.all.each do |skill|
                @developer.skills << skill if params[skill.name.downcase] == "on"
            end
            @developer.save
            # redirect to show developer profile 
            redirect_to developer_path(@developer), notice: "Profile successfully updated."
            # redirect to developer dashboard 
            # redirect_to developer_dashboard_path(@developer), notice: "Profile successfully updated."

        else
            @skills = Skill.all
            render "edit"
        end
    end


    private

    def after_update_path_for(resource)
        developer_path(resource)
    end

end


