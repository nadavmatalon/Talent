
describe Project do

	before (:each) { create_client }

	it 'can be created' do
		name, client_id = 'Test Project', Client.first.id
		expect(Project.new(name: name, client_id: client_id).valid?).to be true
	end

	it 'can be saved in the database' do
		expect(Project.count).to eq 0
		create_project
		expect(Project.count).to eq 1
	end

	it 'can be retrieved from he database' do
		create_project
		expect(Project.first.name).to eq 'Test Project'
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
		create_project('', Client.first.id)
		expect(Project.count).to eq 0
	end	

	it "cannot be saved in the database without a client's id" do
		create_project('Test Project', '')
		expect(Project.count).to eq 0
	end	

	it 'name must be unique' do
		2.times { create_project('Test Project', Client.first.id) }
		expect(Project.count).to eq 1
	end	

	it 'name is case insensitive' do
		create_project('Test Project', Client.first.id)
		create_project('test project', Client.first.id)
		expect(Project.count).to eq 1
	end

	it 'is created without required skills by default' do
		project = create_project
		expect(project.skills.count).to eq 0
	end	

	it 'can have a required skill' do
		project = create_project
		project.skills << create_skill
		expect(project.skills.count).to eq 1
	end	

	it 'can have more than one required skill' do
		project = create_project
		project.skills << create_skill('Skill One') << create_skill('Skill Two')
		expect(project.skills.count).to eq 2
	end	

	it "knows what are it's required skills" do
		project = create_project
		project.skills << create_skill
		expect(project.skills.first.name).to eq 'Test Skill'
	end	

end

