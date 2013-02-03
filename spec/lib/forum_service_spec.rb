require 'spec_helper'

describe ForumService do
  before do
    @andy = Fabricate(:user)
    @george = Fabricate(:user)
    @topic1 = create_forum_topic(@andy)
    @topic2 = create_forum_topic(@george)
    @post = Fabricate(:forum_post, :topic => @topic2, :user => @andy)
  end

  context "When getting a list of topics started by a member" do
    it "returns visible, approved topics that were created by a given user" do
      ForumService.topics_started_by(@andy).should == [@topic1]
    end
  end

  context "When getting a list of topics that a member has participated in" do
    it "returns visible, approved topics where a user has posted" do
      ForumService.topics_with_posts_by(@andy).should include(@topic2)
    end

    it "excludes topics started by the user" do
      ForumService.topics_with_posts_by(@andy).should_not include(@topic1)
    end
  end
end