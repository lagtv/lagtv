require 'spec_helper'

describe CommentsController do
  before do
    @ability = stub_abilities_for_controller
    @current_user = double
    @controller.stub(:current_user) { @current_user }
  end

  context "When adding a new comment" do
    def do_post
      post :create, { :replay_id => "1", :comment => "comment_params" }
    end

    context "without permission" do
      before do
        @ability.cannot :create, Comment
        do_post
      end
      
      it { should redirect_to("http://test.host/") }
      it { should set_the_flash.to(:alert => "You do not have permission to access that page") }
    end  

    context "with permission" do
      before do
        @replay = double.as_null_object
        @comments = double.as_null_object
        @comment = double.as_null_object
        @replay.stub(:to_param) { "1" }
        @replay.stub(:comments) { @comments }
        Replay.stub(:find) { @replay }
        @comments.stub(:build) { @comment }
        @ability.can :create, Comment
      end

      it "loads the replay for the comment to be added to" do
        Replay.should_receive(:find).with("1") { @replay }
        do_post
      end

      it "creates a new comment for the loaded replay" do
        @comments.should_receive(:build).with("comment_params") { @comment }
        do_post
      end

      it "sets the user who posted the comment" do
        @comment.should_receive(:user=).with(@current_user)
        do_post
      end

      it "saves the comment" do
        @comment.should_receive(:save) { true }
        do_post
      end

      context "if save is successful" do
        before do
          @comment.stub(:save) { true }
        end

        it "redirects to the edit replay page" do
          do_post
          @controller.should redirect_to "/replays/1/edit"
        end

        it "sets a flash success message" do
          do_post
          @controller.should set_the_flash.to(/successfully/i)
        end   
      end

      context "if save fails" do
        before do
          @comment.stub(:save) { false }
        end

        it "redirects to the edit replay page" do
          do_post
          @controller.should redirect_to "/replays/1/edit"
        end

        it "sets a flash failure message" do
          do_post
          @controller.should set_the_flash.to(/failed/i)
        end   
      end   
    end
  end
end