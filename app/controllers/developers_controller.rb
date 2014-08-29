class DevelopersController < ApplicationController

	before_action :authenticate_developer!, :confirm_identity

	def index
		
	end

	def show

	end

	private

	def confirm_identity
	    @developer = Developer.find params[:id] unless Developer.find_by(id: params[:id]).nil?
		redirect_to root_path, alert: "Access Denied!" unless @developer == current_developer
	end

end
