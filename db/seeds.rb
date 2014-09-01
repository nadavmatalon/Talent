# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# bin/rake db:setup           runs db:create, db:schema:load, db:seed

# bin/rake db:create          creates the database for the current env
# bin/rake db:reset           runs db:drop db:setup
# bin/rake db:schema:load     loads the schema into the current env's database
# bin/rake db:migrate         runs migrations for the current env that have not run yet
# bin/rake db:drop            drops the database for the current env
# bin/rake db:migrate:status  shows current migration status
# bin/rake db:rollback        rolls back the last migration
# bin/rake db:seed            (only) runs the db/seed.rb file


['Ruby', 'Python', 'JavaScript', 'C++', 'Java', 'Visual Basic'].each do |skill|
	Skill.create(name: skill)
end

# Admin.create(email: Rails.application.secrets.admin_key, password: Rails.application.secrets.admin_secret, password_confirmation: Rails.application.secrets.admin_secret) 

