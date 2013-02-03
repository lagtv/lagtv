def create_forum_topic(user)
  params = { 
    :topic => { 
      :subject => "My First Topic",
      :posts_attributes => [{:text => "First topic text"}]
    }
  }

  forum = Fabricate(:forum)
  topic = forum.topics.build(params[:topic], :as => :default)
  topic.user = user
  topic.save!

  topic
end

def stub_abilities_for_controller
  @ability = Object.new
  @ability.extend(CanCan::Ability)
  @controller.stub(:current_ability) { @ability }
  return @ability
end