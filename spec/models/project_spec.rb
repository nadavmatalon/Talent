require 'rails_helper'

describe "Project" do

	before (:each) { create_client }

	it 'can be created and saved in the database' do
		expect(Project.count).to eq 0
		create_project
		expect(Project.count).to eq 1
	end

	it 'can be retrieved from he database' do
		create_project
		expect(Project.first.name).to eq "test_project"
	end

	it 'can be removed from the database' do
		create_project
		Project.first.destroy
		expect(Project.count).to eq 0
	end	

	it "have status 'pending' by default" do
		create_project
		expect(Project.first.status).to eq 'pending'
	end	

	it 'cannot be saved in the database without a name' do
		create_project("", Client.first.id)
		expect(Project.count).to eq 0
	end	

	it "cannot be saved in the database without a client's id" do
		create_project("test_project", "")
		expect(Project.count).to eq 0
	end	

	it 'name must be unique' do
		client_two = create_client
		create_project("test_project", Client.first.id)
		create_project("test_project", client_two.id)
		expect(Project.count).to eq 1
	end	

	it 'name is case insensitive' do
		client_two = create_client
		create_project("test_project", Client.first.id)
		create_project("Test_Project", client_two.id)
		expect(Project.count).to eq 1
	end

	it "is created without 'required skills' by default" do
		project = create_project
		expect(project.skills.count).to eq 0
	end	

	it "can have a 'required skill'" do
		project = create_project
		project.skills << create_skill
		expect(project.skills.count).to eq 1
	end	

	it "can have more than one 'required skill'" do
		project = create_project
		project.skills << create_skill("Skill_One")
		project.skills << create_skill("Skill_Two")
		expect(project.skills.count).to eq 2
	end	

	it "knows what are it's 'required skills'" do
		project = create_project
		project.skills << create_skill
		expect(project.skills.first.name).to eq "Test Skill"
	end	

end

def create_client (email = "client@example.com", password = "password", password_confirmation = "password")
	Client.create(email: email, password: password, password_confirmation: password_confirmation)
end

def create_project (name="test_project", client_id=Client.first.id, skills=[])
	Project.create(name: name, client_id: client_id, skills: skills)
end

def create_skill (name="Test Skill")
	Skill.create(name: name)
end
