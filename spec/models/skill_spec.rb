
describe Skill do

	it 'can be created' do
		expect(Skill.new(name: 'Test Skill').valid?).to be true
	end

	it 'can be saved in the database' do
		expect(Skill.count).to eq 0
		create_skill
		expect(Skill.count).to eq 1
	end

	it 'can be retrieved from he database' do
		create_skill
		expect(Skill.first.name).to eq "Test Skill"
	end

	it 'can be removed from the database' do
		create_skill
		Skill.first.destroy
		expect(Skill.count).to eq 0
	end	

	it 'have a name' do
		create_skill
		expect(Skill.first.name).to eq 'Test Skill'
	end	

	it 'cannot be saved in the database without a name' do
		create_skill('')
		expect(Skill.count).to eq 0
	end	

	it 'have a unique name' do
		2.times { create_skill }
		expect(Skill.count).to eq 1
	end	

	it 'their name is case insensitive' do
		create_skill('test skill')
		create_skill('Test skill')
		expect(Skill.count).to eq 1
	end	
	
end

