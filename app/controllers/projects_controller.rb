class ProjectsController < ApplicationController

	before_action :authenticate_client!, :confirm_identity	
	before_action :confirm_ownership, only: [:show, :edit, :update, :destroy]
    before_action :all_skills, except: [:show, :destroy]
    before_action :marked_skills, only: [:new, :create, :update]

	def new
		@project = @client.projects.new
	end

	def create
		@project = @client.projects.new project_params
		populate @marked_skills
		if @project.save
			populate @project.skills
            flash[:notice] = 'Project successfully created'
			#redirect to client dashboard
			redirect_to client_dashboard_path(@client)
			# redirect to show project
			# redirect_to client_project_path(@client, @project)
		else
			render 'new'
		end
	end

	def show

	end

	def edit
		@marked_skills = @project.skills
	end

	def update
		populate @marked_skills
   		if @project.update project_params
   			populate @project.skills
			@project.save
			flash[:notice] = 'Project successfully updated'
   			# redirect to show project  
			redirect_to client_project_path(@client, @project)
   			# redirect to client dashboard
   			# redirect_to client_dashboard_path(@client)
		else
			render 'edit'
		end
	end

	def destroy
		@project.destroy
		redirect_to client_dashboard_path(@client), notice: 'Project successfully deleted'
	end


	private

    def all_skills
        @skills = Skill.all
    end

    def marked_skills
        @marked_skills = []
    end

   def populate skills
        skills.clear if skills.any?
        Skill.all.each { |skill| skills << skill if params[skill.name.downcase] == 'on' }             
    end

	def project_params
		params[:project].permit(:id, :name, :status, :client_id, skill: :name)
	end

	def confirm_identity
		@client = Client.find params[:client_id] unless Client.find_by(id: params[:client_id]).nil?
		redirect_to root_path, alert: 'Access Denied!' unless @client == current_client
	end

	def confirm_ownership
		@project = Project.find params[:id] unless Project.find_by(id: params[:id]).nil?
		redirect_to root_path, alert: 'Access Denied!' unless @client.projects.include?(@project)
	end

end
