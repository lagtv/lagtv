require 'spec_helper'

describe ReplaysController do
  before do
    @ability = stub_abilities_for_controller
    @current_user = double
    @controller.stub(:current_user) { @current_user }
  end

  context "When showing the list of users" do
    context "without permission" do
      before do
        @ability.cannot :manage, Replay
        get :index
      end
      
      it { should redirect_to("http://test.host/") }
      it { should set_the_flash.to(:alert => "You do not have permission to access that page") }
    end

    context "with permission" do
      before do
        @ability.can :manage, Replay
      end

      context "rendering checks" do
        before do
          Replay.stub(:all_paged)
          get :index
        end

        it { should respond_with(:success) }
        it { should render_template(:index) }
        it { should_not set_the_flash } 
      end

      it "loads the replay list" do
        params = { :page => "1" }
        Replay.should_receive(:all_paged).with(params)
        get :index, params
      end
    end
  end

  context "When creating a new replay" do
    def do_post
      post :create, { :replay => @posted_replay }
    end

    before do
      @posted_replay = { "title" => 'Blah' }
      @replay = Fabricate.build(:replay)
      @current_user.stub(:build_replay) { @replay }
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

      it "builds a new replay for the current user" do
        @current_user.should_receive(:build_replay).with(@posted_replay) { @replay }
        do_post
      end

      context "and saving is successful" do
        before do
          @replay.stub(:save) { true }
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

        it "assigns the categories list" do
          do_post
          should assign_to(:categories)
        end
      end
    end
  end
end