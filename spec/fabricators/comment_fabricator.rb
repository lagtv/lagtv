Fabricator(:comment) do
  text "This replay is great"
  user!
  replay!
end