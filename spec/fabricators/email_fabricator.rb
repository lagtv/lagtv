Fabricator(:email) do
  id { sequence(:id) }
  subject { sequence(:email_num) { |i| "Weekly Update ##{i}" } }
  body { "Hey there, hi there, ho there." }
  total_sent { rand(10000) }
  roles { User.ROLES.sample(rand(User.ROLES.length)) }
end