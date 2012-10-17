Replay.destroy_all
Category.destroy_all
Comment.destroy_all
Category.create!(:name => 'Normal Game')
Category.create!(:name => 'When Cheese Fails')
Category.create!(:name => 'Inbox to Icebox')

Forem::Category.reset_column_information
Forem::Category.destroy_all

Forem::Post.reset_column_information
Forem::Post.destroy_all

Forem::Topic.reset_column_information
Forem::Topic.destroy_all

Forem::Forum.reset_column_information
Forem::Forum.destroy_all

all_forums = {
  "Platforms" => ['PC', 'Xbox', 'PS3', 'Wii', 'Handheld / Mobile'],
  "Gaming" => ['General'],
  "E-Sports" => ['General'],
  "LAG TV" => ['LAGTV1 Channel', 'LAGTV2 Channel', 'Events'],
  "Off-Topic" => ['General'],
  "Tech" => ['Hardware', 'Software'],
  "Support" => ['User FAQ', 'Report Bugs', 'Suggestions'],
}

all_forums.each do |category_name, forums|
  category = Forem::Category.create!(:name => category_name)
  forums.each do |title|
    Forem::Forum.create!(:category_id => category.id, :title => title, :description => "Talk all about #{title} stuff")
  end
end

