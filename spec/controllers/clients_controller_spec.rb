require 'rails_helper'

describe ClientsController do

	let (:client) { create_client }

	before (:each) { sign_in client }

  	it "renders the 'clients/index' view", scope: :client do
      	get :index, id: client.id
     	expect(response).to have_http_status(:ok)
      	expect(controller.current_client).to eq client
      	expect(controller.controller_path).to eq 'clients'
      	expect(response).to render_template 'clients/index'
	end

 	it "renders the 'clients/show' view", scope: :client do
        get :show, id: client.id
      	expect(response).to have_http_status(:ok)
      	expect(controller.current_client).to eq client
      	expect(controller.controller_path).to eq 'clients'
      	expect(response).to render_template 'clients/show'
	end

end

