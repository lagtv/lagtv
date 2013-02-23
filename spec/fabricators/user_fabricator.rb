Fabricator(:user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe_Bloggs_#{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "member"
  forem_state "approved"
  profile_url { sequence(:profile_url) { |i| "user_#{i}" } }
end

Fabricator(:member, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe_Bloggs_#{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "member"
  forem_state "approved"
  profile_url { sequence(:profile_url) { |i| "user_#{i}" } }
end

Fabricator(:admin, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe_Bloggs_#{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "admin"
  forem_state "approved"
  profile_url { sequence(:profile_url) { |i| "user_#{i}" } }
end

Fabricator(:community_manager, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe_Bloggs_#{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "community_manager"
  forem_state "approved"
  profile_url { sequence(:profile_url) { |i| "user_#{i}" } }
end

Fabricator(:moderator, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe_Bloggs_#{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "moderator"
  forem_state "approved"
  profile_url { sequence(:profile_url) { |i| "user_#{i}" } }
end

Fabricator(:analyst, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe_Bloggs_#{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "analyst"
  forem_state "approved"
  profile_url { sequence(:profile_url) { |i| "user_#{i}" } }
end

Fabricator(:dev_team, :from => :user) do
  id { sequence(:id) }
  name { sequence(:name) { |i| "Joe_Bloggs_#{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "dev_team"
  forem_state "approved"
  profile_url { sequence(:profile_url) { |i| "user_#{i}" } }
end