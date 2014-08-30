require 'rails_helper'

describe DevelopersController do

	let (:developer) { create_developer }

	before (:each) { sign_in developer }

  	it "renders the 'developers/index' view", scope: :developer do
      	get :index, id: developer.id
       	expect(response).to have_http_status :ok
      	expect(controller.current_developer).to eq developer
      	expect(controller.controller_path).to eq 'developers'
      	expect(response).to render_template 'developers/index'
	end

 	it "renders the 'developers/show' view", scope: :client do
        get :show, id: developer.id
      	expect(response).to have_http_status :ok
      	expect(controller.current_developer).to eq developer
      	expect(controller.controller_path).to eq 'developers'
      	expect(response).to render_template 'developers/show'
	end
end


def create_developer (email = "developer@example.com", password = "password", password_confirmation = "password")
	Developer.create(email: email, password: password, password_confirmation: password_confirmation)
end
