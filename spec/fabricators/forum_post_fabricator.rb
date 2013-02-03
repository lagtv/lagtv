Fabricator(:forum_post, :from => Forem::Post.name.underscore.to_sym) do
  id { sequence(:id) }
  text "My first post"
  user  { Fabricate(:user) }
  state "approved"
end