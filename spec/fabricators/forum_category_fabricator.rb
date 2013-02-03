Fabricator(:forum_category, :from => Forem::Category.name.underscore.to_sym) do
  id { sequence(:id) }
  name "My category"
end