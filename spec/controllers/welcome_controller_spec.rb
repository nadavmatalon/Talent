require 'rails_helper'

describe WelcomeController do

	it "renders the 'welcome/index' view" do
		get :index
      	expect(response).to have_http_status(:ok)
		expect(response).to render_template("layouts/application")
	end
end

