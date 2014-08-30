require 'rails_helper'

describe DevelopersController do

  	it "renders the 'welcome/index' view", scope: :developer do
		@developer = create_developer
		sign_in @developer
      	get :index, session: { email: @developer.email, password: @developer.password }
      	expect(controller.current_developer).to eq @developer
	end

end



def create_developer (email = "developer@example.com", password = "password", password_confirmation = "password")
	Developer.create(email: email, password: password, password_confirmation: password_confirmation)
end
