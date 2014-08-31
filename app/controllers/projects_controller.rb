class ProjectsController < ApplicationController

	before_action :authenticate_client!, :confirm_identity
	
	before_action :confirm_ownership, only: [:show, :edit, :update, :destroy]

	def new
		@skills = Skill.all
		@marked_skills = []
		@project = @client.projects.new
	end

	def create
		@project = @client.projects.new project_params
		@marked_skills = []
		Skill.all.each do |skill|			
			@marked_skills << skill if params[skill.name.downcase] == "on"			 	
		end
		if @project.save
			Skill.all.each do |skill|			
				@project.skills << skill if params[skill.name.downcase] == "on"			 	
			end
			#redirect back to the client dashboard
			redirect_to client_dashboard_path(@client), notice: "Project successfully created."
			# redirect to the show project
			# redirect_to client_project_path(@client, @project)
		else
			@skills = Skill.all
			render "new"
		end
	end

	def show

	end

	def edit
		@skills = Skill.all
		@marked_skills = @project.skills
	end

	def update
		@marked_skills = []
		Skill.all.each do |skill|			
			@marked_skills << skill if params[skill.name.downcase] == "on"			 	
		end
   		if @project.update project_params
			@project.skills.clear
			Skill.all.each do |skill|
				@project.skills << skill if params[skill.name.downcase] == "on" 	
			end
			@project.save
   			# redirect to the show project  
			redirect_to client_project_path(@client, @project), notice: "Project successfully updated."
   			# redirect back to the client dashboard
   			# redirect_to client_dashboard_path(@client), notice: "Project successfully updated."
		else
			@skills = Skill.all
			render "edit"
		end
	end

	def destroy
		@project.destroy
		redirect_to client_dashboard_path(@client), notice: "Project successfully deleted."
	end


	private

	def project_params
		params[:project].permit(:id, :name, :status, :client_id, skill: :name)
	end

	def confirm_identity
		@client = Client.find params[:client_id] unless Client.find_by(id: params[:client_id]).nil?
		redirect_to root_path, alert: "Access Denied!" unless @client == current_client
	end

	def confirm_ownership
		@project = Project.find params[:id] unless Project.find_by(id: params[:id]).nil?
		redirect_to root_path, alert: "Access Denied!" unless @client.projects.include?(@project)
	end

end
