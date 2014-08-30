class Skill < ActiveRecord::Base

	has_and_belongs_to_many :projects

	validates :name, presence: true, allow_blank: false, uniqueness: { case_sensitive: false }
	
end
