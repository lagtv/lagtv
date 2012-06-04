require 'spec_helper'

describe Comment do
  context "When validating a comment" do
    before do
      @comment = Fabricate(:comment)
    end
    
    it { @comment.should validate_presence_of(:text) }
    it { @comment.should validate_presence_of(:replay_id) }
    it { @comment.should validate_presence_of(:user_id) }
  end
end
