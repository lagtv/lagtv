Fabricator(:user) do
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "member"
end

Fabricator(:admin, :from => :user) do
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "admin"
end

Fabricator(:community_manager, :from => :user) do
  name { sequence(:name) { |i| "Joe Bloggs #{i}" } }
  email { sequence(:email) { |i| "person#{i}@example.com" } }
  password "secret"
  password_confirmation "secret"
  role "community_manager"
end