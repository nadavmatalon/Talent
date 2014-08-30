require 'rails_helper'

describe WelcomeController do

	it "renders the 'welcome/index' view" do
		# @client = create_client
		# sign_in @client
		get :index
      	expect(response).to have_http_status(:ok)
		expect(response).to render_template("layouts/application")
	end
end



def create_client (email = "client@example.com", password = "password", password_confirmation = "password")
	Client.create(email: email, password: password, password_confirmation: password_confirmation)
end
