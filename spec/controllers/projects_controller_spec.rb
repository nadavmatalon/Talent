require 'rails_helper'

describe ProjectsController do

	let (:client) { create_client }

    let (:project) { create_project }

	before (:each) { sign_in client }

    it "renders the 'projects/new' view", scope: :project do
        get :new, client_id: client.id
        expect(response).to have_http_status(:ok)
        expect(controller.current_client).to eq client
        expect(controller.controller_path).to eq 'projects'
      	expect(response).to render_template 'projects/new'
	end

 	it "renders the 'projects/show' view", scope: :project do
        get :show, id: project.id, client_id: client.id
      	expect(response).to have_http_status(:ok)
      	expect(controller.current_client).to eq client
      	expect(controller.controller_path).to eq 'projects'
      	expect(response).to render_template 'projects/show'
	end

  it "renders the 'projects/edit' view", scope: :project do
        get :edit, id: project.id, client_id: client.id
        expect(response).to have_http_status(:ok)
        expect(controller.current_client).to eq client
        expect(controller.controller_path).to eq 'projects'
        expect(response).to render_template 'projects/edit'
  end

end

