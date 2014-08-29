class ProjectsController < ApplicationController

	def new
		@client = Client.find params[:client_id]
		@project = @client.projects.new
	end

	def create
		@client = Client.find params[:client_id]
		@project = @client.projects.create project_params
		if @project.valid?
			redirect_to client_dashboard_path(@client)  #redirect back to the client dashboard
			# redirect_to client_project_path(@client, @project) #redirect to the show project
		else
			render "new"
		end
	end

	def show
		@client = Client.find params[:client_id]
		@project = Project.find params[:id]
	end

	def edit
		@client = Client.find params[:client_id]
		@project = Project.find params[:id]
	end

	def update
		@client = Client.find params[:client_id] 
		@project = Project.find params[:id]
		@project.update project_params
   		if !@project.errors.messages.any?
   			redirect_to client_dashboard_path(@client)  #redirect back to the client dashboard
			# redirect_to client_project_path(@client, @project) #redirect to the show project
		else
			render "edit"
		end
	end


	private

	def project_params
		params[:project].permit(:id, :name, :status, :client_id, :errors, :messages)
	end

end
