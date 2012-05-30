require 'spec_helper'

describe HomeController do
  context "When showing the homepage of the site" do
    before do
      get :index
    end

    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should_not set_the_flash } 
  end

  context "When loading the YouTube data" do
    before do
      @lagtv1_service = double.as_null_object
      @lagtv2_service = double.as_null_object
      YouTubeService.stub(:new).with('lifesaglitchtv', @controller.cache_store) { @lagtv1_service }
      YouTubeService.stub(:new).with('lifesaglitchtv2', @controller.cache_store) { @lagtv2_service }
    end

    it "gets the YouTube channel data for lifesaglitchtv" do 
      @lagtv1_service.should_receive(:channel)
      get :index
    end

    it "gets the YouTube channel data for lifesaglitchtv2" do 
      @lagtv2_service.should_receive(:channel)
      get :index
    end
  end

  context "When building the replay form" do
    before do
      @ability = stub_abilities_for_controller
      @current_user = double.as_null_object
      @controller.stub(:current_user) { @current_user }
    end

    context "for a user without permission" do
      before do
        @ability.cannot :create, Replay
        get :index
      end

      it "doesn't assign the replay instance" do      
        should_not assign_to(:replay)
      end

      it "assigns categories" do
        should_not assign_to(:categories)
      end
    end

    context "with permission" do
      before do
        @ability.can :create, Replay
        get :index
      end

      it "assigns the replay instance" do
        should assign_to(:replay)
      end

      it "assigns categories" do
        should assign_to(:categories)
      end
    end
  end
end