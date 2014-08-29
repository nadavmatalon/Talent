class ClientsController < ApplicationController

	before_action :authenticate_client!, :confirm_identity

	def index
	    @projects = @client.projects.to_a.sort_by {|project| project.id}.reverse
	end

	def show

	end

	private

	def confirm_identity
		@client = Client.find params[:id] unless Client.find_by(id: params[:id]).nil?
		redirect_to root_path, alert: "Access Denied!" unless @client == current_client
	end

end


