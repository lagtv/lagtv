Fabricator(:forum_topic, :from => Forem::Topic.name.underscore.to_sym) do
  id { sequence(:id) }
  subject "My first topic"
  forum { Fabricate(:forum) }
  state "approved"
  user  { Fabricate(:user) }
  posts(count: 1) { |attrs, i| Fabricate(:forum_post) }
end