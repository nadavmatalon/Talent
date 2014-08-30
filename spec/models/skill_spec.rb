require 'rails_helper'

describe "Skill" do

	it 'can be created and saved in the database' do
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

	it 'cannot be saved in the database without a name' do
		create_skill("")
		expect(Skill.count).to eq 0
	end	
	
end


def create_skill (name="Test Skill")
	Skill.create(name: name)
end
