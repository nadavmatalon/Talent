class DevelopersController < ApplicationController

before_action :authenticate_developer!

	def index
	    @developer = Developer.find params[:id] 
	    redirect_to '/' unless @developer == current_developer
	end

	def show
	    @developer = Developer.find params[:id] 
	    redirect_to '/' unless @developer == current_developer
	end

end
