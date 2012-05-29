require 'spec_helper'

describe ReplaysController do
  before do
    @ability = stub_abilities_for_controller
    @current_user = double
    @controller.stub(:current_user) { @current_user }
  end

  context "When creating a new replay" do
    def do_post
      post :create, { :replay => @posted_replay }
    end

    before do
      @posted_replay = { "title" => 'Blah' }
      @replays = double
      @replay = double
      @current_user.stub(:replays) { @replays }
      @replays.stub(:build) { @replay }
    end

    context "without permission" do
      before do
        @ability.cannot :create, @replay
        do_post
      end

      it { should redirect_to("http://test.host/") }
      it { should set_the_flash.to(:alert => "You do not have permission to access that page") }
    end

    context "with permission" do
      before do
        @ability.can :create, @replay
      end

      context "and saving is successful" do
        before do
          @replay.stub(:save) { true }
        end

        it "instanciates a new replay with the posted fields" do
          @replays.should_receive(:build).with(@posted_replay) { @replay }
          do_post
        end

        it "saves the new replay" do
          @replay.should_receive(:save) { true }
          do_post
        end    

        it "redirects to the home page after successfully saving" do
          do_post
          @controller.should redirect_to root_url
        end

        it "adds a flash message after successfully saving" do
          do_post
          @controller.should set_the_flash.to(/successfully/i)
        end
      end

      context "and saving fails" do
        before do
          @replay.stub(:save) { false }
        end

        it "renders the new view" do
          do_post
          @controller.should render_template(:new)
        end
      end
    end
  end
end