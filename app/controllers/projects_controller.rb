class ProjectsController < ApplicationController

	def new
		@client = Client.find params[:client_id]
		@project = @client.projects.new
	end

	def create
		@client = Client.find params[:client_id]
		@project = @client.projects.new project_params
		if @project.save
			#redirect back to the client dashboard
			redirect_to client_dashboard_path(@client), notice: "Project successfully created."
			# redirect to the show project
			# redirect_to client_project_path(@client, @project)
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
   		if @project.update project_params
   			# redirect back to the client dashboard
   			redirect_to client_dashboard_path(@client), notice: "Project successfully updated."
   			# redirect to the show project  
			# redirect_to client_project_path(@client, @project)
		else
			render "edit"
		end
	end

	def destroy
		@client = Client.find params[:client_id]
		@project = Project.find params[:id]
		@project.destroy
		redirect_to client_dashboard_path(@client), notice: "Project successfully deleted."
	end


	private

	def project_params
		params[:project].permit(:id, :name, :status, :client_id)
	end

end
