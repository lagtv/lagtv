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
      @service = double.as_null_object
      YouTubeService.stub(:new){ @service }
    end

    it "gets the latest video data" do 
      @service.should_receive(:latest_video)
      get :index
    end

    it "gets the recent videos list" do 
      @service.should_receive(:recent_videos)
      get :index
    end
  end
end