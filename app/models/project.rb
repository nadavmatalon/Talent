class Project < ActiveRecord::Base

	belongs_to :client, inverse_of: :projects
	validates_presence_of :client
	validates :name, presence: true, allow_blank: false, uniqueness: { case_sensitive: false }

end
