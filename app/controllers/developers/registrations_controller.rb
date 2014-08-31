class Developers::RegistrationsController < Devise::RegistrationsController

    def new
        @skills = Skill.all
        @marked_skills = []
        @developer = Developer.new
    end

    def create
        @developer = Developer.new developer_params
        @marked_skills = []
        Skill.all.each do |skill|           
            @marked_skills << skill if params[skill.name.downcase] == "on"              
        end
        if @developer.save
            Skill.all.each do |skill|           
                @developer.skills << skill if params[skill.name.downcase] == "on"             
            end
            sign_in @developer
            redirect_to developer_dashboard_path(@developer), notice: "Signed up successfully."
        else
            @skills = Skill.all
            render "new"
        end
    end

    def edit
        @skills = Skill.all
        @marked_skills = @developer.skills
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

        @marked_skills = []
        Skill.all.each do |skill|           
            @marked_skills << skill if params[skill.name.downcase] == "on"              
        end

        if @developer.update_attributes(account_update_params)
            @developer.skills.clear
            Skill.all.each do |skill|
                @developer.skills << skill if params[skill.name.downcase] == "on"
            end
            @developer.save
            sign_in @developer, bypass: true
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

    def developer_params
        params[:developer].permit(:id, :email, :password, :password_confirmation, skill: :name)
    end

    def after_update_path_for(resource)
        developer_path(resource)
    end

end


