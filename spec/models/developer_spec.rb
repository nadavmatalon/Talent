
describe Developer do

	it 'can be created and saved in the database' do
		expect(Developer.count).to eq 0
		create_developer
		expect(Developer.count).to eq 1
	end

	it 'can be retrieved from he database' do
		create_developer
		expect(Developer.first.email).to eq "developer@example.com"
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

	it 'have their passowrd saved as a diagest password the database' do
		create_developer
		expect(Developer.first.encrypted_password.chars.count).to eq 60
	end	

	it 'cannot be saved in the database without an email' do
		create_developer("", "password", "password")
		expect(Developer.count).to eq 0
	end	

	it 'cannot be saved in the database without a password' do
		create_developer("developer@example.com", "", "password")
		expect(Developer.count).to eq 0
	end	

	it 'cannot be saved in the database without password confirmation' do
		create_developer("developer@example.com", "password", "")
		expect(Developer.count).to eq 0
	end	

	it 'their password and password confirmation must match' do
		create_developer("developer@example.com", "password", "wrong-password")
		expect(Developer.count).to eq 0
	end	

	it 'their email must be unique' do
		2.times { create_developer }
		expect(Developer.count).to eq 1
	end	

end

