require 'spec_helper'

describe ForumService do
  before do
    @topic = Fabricate(:forum_topic)
  end

  context "When getting a list of topics started by a member" do
    it "returns visible, approved topics that were created by a given user" do
      
    end
  end

  context "When getting a list of topics that a member has participated in" do
    it "returns visible, approved topics where a user has posted" do
      
    end

    it "excludes topics started by the user" do
      
    end
  end
end