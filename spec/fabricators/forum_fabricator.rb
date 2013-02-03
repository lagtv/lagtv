Fabricator(:forum, :from => Forem::Forum.name.underscore.to_sym) do
  id { sequence(:id) }
  title "My forum"
  description "A cool forum"
  category { Fabricate(:forum_category) }
end