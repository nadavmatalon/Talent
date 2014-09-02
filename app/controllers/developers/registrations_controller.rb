class Developers::RegistrationsController < Devise::RegistrationsController

    before_action :all_skills, only: [:edit, :update]
    before_action :marked_skills, only: [:edit, :update]

    def new
        @developer = Developer.new
    end

    def create
        sign_up_params = devise_parameter_sanitizer.sanitize(:sign_up)
        @developer = Developer.new sign_up_params
        if @developer.save
            sign_in @developer
            flash[:notice] = 'Signed up successfully'
            redirect_to developer_dashboard_path(@developer)
        else
            render 'new'
        end
    end

    def edit
        @marked_skills = @developer.skills
    end

    def update
        update_params = devise_parameter_sanitizer.sanitize(:developer_update)
        if update_params[:password].blank?
            update_params.delete('password')
            update_params.delete('password_confirmation')
        end
        @developer = Developer.find_by(id: current_developer.id)
        populate @marked_skills
        if @developer.update_attributes update_params
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

    def all_skills
       @skills = []
        Skill.all.each do |skill| 
            skill.name.gsub!(/\s+/, '_') if skill.name.include?(' ')
            @skills << skill
        end
    end

    def marked_skills
        @marked_skills = []
    end

    def populate skills
        skills.clear if skills.any?
        Skill.all.each do |skill| 
            skill.name.gsub!(/\s+/, '_') if skill.name.include?(' ')
            skills << skill if params[skill.name.downcase] == 'on'
        end
    end

end

