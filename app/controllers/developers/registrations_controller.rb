class Developers::RegistrationsController < Devise::RegistrationsController

    before_action :all_skills

    before_action :marked_skills, except: [:edit]

    def new
        @developer = Developer.new
    end

    def create
        @developer = Developer.new developer_params
        populate @marked_skills
        if @developer.save
            populate @developer.skills
            sign_in @developer
            flash[:notice] = 'Signed up successfully'
            redirect_to developer_dashboard_path(@developer)
        else
            render "new"
        end
    end

    def edit
        @marked_skills = @developer.skills
    end

    def update
        account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
        if account_update_params[:password].blank?
            account_update_params.delete('password')
            account_update_params.delete('password_confirmation')
        end
        @developer = Developer.find_by(id: current_developer.id)
        populate @marked_skills
        if @developer.update_attributes account_update_params
            populate @developer.skills
            @developer.save
            sign_in @developer, bypass: true
            flash[:notice] = 'Profile successfully updated'
            # redirect to show developer profile 
            redirect_to developer_path(@developer)
            # redirect to developer dashboard 
            # redirect_to developer_dashboard_path(@developer)
        else
            render 'edit'
        end
    end


    private

    def developer_params
        params[:developer].permit(:id, :email, :password, :password_confirmation, skill: :name)
    end

    def after_update_path_for resource
        developer_path resource
    end

    def all_skills
        @skills = Skill.all
    end

    def marked_skills
        @marked_skills = []
    end

    def populate skills
        skills.clear if skills.any?
        Skill.all.each { |skill| skills << skill if params[skill.name.downcase] == "on" }             
    end

end

