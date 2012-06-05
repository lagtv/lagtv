require 'spec_helper'

describe Comment do
    before do
      @replay = Fabricate(:replay)
      @comment = Fabricate.build(:comment, :replay => @replay)
    end

  context "When validating a comment" do
    it { @comment.should validate_presence_of(:text) }
    it { @comment.should validate_presence_of(:replay_id) }
    it { @comment.should validate_presence_of(:user_id) }
  end

  context "When creating a comment" do
    it "updates the replays average rating" do
      @replay.should_receive(:update_average_rating)
      @comment.save!
    end
  end
end
