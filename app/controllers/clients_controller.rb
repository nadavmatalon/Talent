class ClientsController < ApplicationController

before_action :authenticate_client!

	def index
	    @client = Client.find params[:id]
	    @projects = @client.projects.to_a.sort_by {|project| project.id}.reverse
	    redirect_to root_path unless @client == current_client
	end

	def show
	    @client = Client.find params[:id] 
	    redirect_to root_path unless @client == current_client
	end

end
