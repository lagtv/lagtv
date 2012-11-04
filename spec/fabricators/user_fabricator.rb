Fabricator(:user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "member"
  forem_state "approved"
end

Fabricator(:member, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "member"
  forem_state "approved"
end

Fabricator(:admin, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "admin"
  forem_state "approved"
end

Fabricator(:community_manager, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "community_manager"
  forem_state "approved"
end

Fabricator(:moderator, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "moderator"
  forem_state "approved"
end

Fabricator(:analyst, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "analyst"
  forem_state "approved"
end

Fabricator(:dev_team, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "dev_team"
  forem_state "approved"
end