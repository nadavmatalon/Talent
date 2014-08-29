class ProjectsController < ApplicationController

	before_action :authenticate_client!, :confirm_identity
	
	before_action :confirm_ownership, only: [:show, :edit, :update, :destroy]

	def new
		@project = @client.projects.new
	end

	def create
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

	end

	def edit

	end

	def update
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
		@project.destroy
		redirect_to client_dashboard_path(@client), notice: "Project successfully deleted."
	end


	private

	def project_params
		params[:project].permit(:id, :name, :status, :client_id)
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
