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
      @lagtv_service = double.as_null_object
      YouTubeService.stub(:new).with('lifesaglitchtv', @controller.cache_store) { @lagtv_service }
    end

    it "gets the YouTube channel data for lifesaglitchtv" do 
      @lagtv_service.should_receive(:channel)
      get :index
    end
  end
end