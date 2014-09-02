class WelcomeController < ApplicationController

	def index
		if current_client
			redirect_to client_dashboard_path(current_client.id)
		elsif current_developer
			redirect_to developer_dashboard_path(current_developer.id)
		end
	end

end

