
describe Client do

	it 'can be created' do
		email, password = 'client@test.com', 'password'
		expect(Client.new(email: email, password: password, password_confirmation: password).valid?).to be true
	end

	it 'can be saved in the database' do
		expect(Client.count).to eq 0
		create_client
		expect(Client.count).to eq 1
	end

	it 'can be retrieved from he database' do
		create_client
		expect(Client.first.email).to eq 'client@example.com'
	end

	it 'can be removed from the database' do
		create_client
		Client.first.destroy
		expect(Client.count).to eq 0
	end

	it 'do not have their passowrd saved in the database' do
		create_client
		expect(Client.first.password).to eq nil
	end

	it 'have their passowrd saved as a diagest password the database' do
		create_client
		expect(Client.first.encrypted_password.chars.count).to eq 60
	end

	it 'cannot be saved in the database without an email' do
		create_client('', 'password', 'password')
		expect(Client.count).to eq 0
	end

	it 'cannot be saved in the database without a password' do
		create_client('client@example.com', '', 'password')
		expect(Client.count).to eq 0
	end

	it 'cannot be saved in the database without password confirmation' do
		create_client('client@example.com', 'password', '')
		expect(Client.count).to eq 0
	end

	it 'their password and password confirmation must match' do
		create_client('client@example.com', 'password', 'wrong-password')
		expect(Client.count).to eq 0
	end

	it 'their password cannot be shorter than 8 characters' do
		create_client('client@example.com', '7-chars', '7-chars')
		expect(Client.count).to eq 0
	end

	it 'their email must be unique' do
		2.times { create_client }
		expect(Client.count).to eq 1
	end

	it 'their email is case insensitive' do
		create_client('client@example.com', 'password', 'password')
		create_client('Client@example.com', 'password', 'password')
		expect(Client.count).to eq 1
	end

	it 'know what their is email' do
		create_client
		expect(Client.first.email).to eq 'client@example.com'
	end

	it 'are created without projects by default' do
		client = create_client
		expect(client.projects.count).to eq 0
	end	

	it 'can have a project' do
		client = create_client
		client.projects << create_project
		expect(client.projects.count).to eq 1
	end	

	it 'can have more than one project' do
		client = create_client
		client.projects << create_project('Project One', client.id)
		client.projects << create_project('Project Two', client.id)
		expect(client.projects.count).to eq 2
	end	

	it 'knows what are their projects' do
		client = create_client
		client.projects << create_project
		expect(client.projects.first.name).to eq 'Test Project'
	end	

end

