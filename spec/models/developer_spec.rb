
describe Developer do

	it 'can be created' do
		email, password = 'developer@test.com', 'password'
		expect(Developer.new(email: email, password: password, password_confirmation: password).valid?).to be true
	end

	it 'can be saved in the database' do
		expect(Developer.count).to eq 0
		create_developer
		expect(Developer.count).to eq 1
	end

	it 'can be retrieved from he database' do
		create_developer
		expect(Developer.first.email).to eq 'developer@example.com'
	end

	it 'can be removed from the database' do
		create_developer
		Developer.first.destroy
		expect(Developer.count).to eq 0
	end

	it 'do not have their passowrd saved in the database' do
		create_developer
		expect(Developer.first.password).to eq nil
	end

	it 'have their passowrd saved as a password diagest the database' do
		create_developer
		expect(Developer.first.encrypted_password.chars.count).to eq 60
	end

	it 'cannot be saved in the database without an email' do
		create_developer('', 'password', 'password')
		expect(Developer.count).to eq 0
	end

	it 'cannot be saved in the database without a password' do
		create_developer('developer@example.com', '', 'password')
		expect(Developer.count).to eq 0
	end

	it 'cannot be saved in the database without password confirmation' do
		create_developer('developer@example.com', 'password', '')
		expect(Developer.count).to eq 0
	end

	it 'their password and password confirmation must match' do
		create_developer('developer@example.com', 'password', 'wrong-password')
		expect(Developer.count).to eq 0
	end

	it 'their password cannot be shorter than 8 characters' do
		create_developer('developer@example.com', '7-chars', '7-chars')
		expect(Developer.count).to eq 0
	end

	it 'their email must be unique' do
		2.times { create_developer }
		expect(Developer.count).to eq 1
	end

	it 'their email is case insensitive' do
		create_developer('developer@example.com', 'password', 'password')
		create_developer('Developer@example.com', 'password', 'password')
		expect(Developer.count).to eq 1
	end

	it 'know what their is email' do
		create_developer
		expect(Developer.first.email).to eq 'developer@example.com'
	end	

	it 'have no skills by default' do
		create_developer
		expect(Developer.first.skills.count).to eq 0		
	end

	it 'can have a skill' do
		developer = create_developer
		developer.skills << create_skill
		expect(developer.skills.count).to eq 1
	end

	it 'can have more than one skill' do
		developer = create_developer
		developer.skills << create_skill('skill_one') << create_skill('skill_two')
		expect(developer.skills.count).to eq 2
	end

	it 'know what are their skills' do
		developer = create_developer
		developer.skills << create_skill
		expect(developer.skills.first.name).to eq 'Test Skill'
	end

end

