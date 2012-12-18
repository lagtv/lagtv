Fabricator(:email) do
  id { sequence(:id) }
  subject { "Weekly Update #1" }
  body { "Hey there, hi there, ho there." }
  total_sent { rand(10000) }
  roles { User::ROLES.sample( [1, rand(User::ROLES.length)].max ) }
end