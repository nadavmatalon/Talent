
def create_client (email = "client@example.com", password = "password", password_confirmation = "password")
	Client.create(email: email, password: password, password_confirmation: password_confirmation)
end

def create_developer (email = "developer@example.com", password = "password", password_confirmation = "password")
	Developer.create(email: email, password: password, password_confirmation: password_confirmation)
end

def create_project (name="Test Project", client_id=Client.first.id, skills=[])
	Project.create(name: name, client_id: client_id, skills: skills)
end

def create_skill (name="Test Skill")
	Skill.create(name: name)
end