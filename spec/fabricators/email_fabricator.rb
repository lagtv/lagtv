Fabricator(:email) do
  id { sequence(:id) }
  subject { "Weekly Update #1" }
  body { "Hey there, hi there, ho there." }
  started_at { Time.now - 200 - rand(1000) }
  ended_at { rand(2) == 1 ? Time.now - rand(150) : nil }
  total_sent { rand(1000) }
  total_recipients { 1000 + rand(10000) }
  roles { User::ROLES.sample( [1, rand(User::ROLES.length)].max ).join(' ') }
end