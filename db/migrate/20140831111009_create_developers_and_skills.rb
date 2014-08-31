class CreateDevelopersAndSkills < ActiveRecord::Migration
  def change
    create_table :developers_skills, id: false do |t|
      t.belongs_to :developer
      t.belongs_to :skill
    end
  end
end
