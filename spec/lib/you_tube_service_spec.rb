require 'spec_helper'

describe YouTubeService do
  context "When retrieving videos from youtube" do
    before do
      @cache = double
      @client = double
      YouTubeIt::Client.stub(:new) { @client }      
      @service = YouTubeService.new(@cache)

      @channel_info = double
      @videos = [:video1, :video2, :video3, :video4, :video5, :video6]
      @channel_info.stub(:videos) { @videos }
      @cache.stub(:read) { nil }
      @cache.stub(:write)
    end

    context "When retrieving the latest video" do
      it "gets all videos for lifesaglitchtv using the you tube client" do
        @client.should_receive(:videos_by).with(:user => 'lifesaglitchtv') { @channel_info }
        @service.latest_video
      end

      it "returns the first video in the collection" do
        @client.stub(:videos_by) { @channel_info }
        @service.latest_video.should == :video1
      end

      it "leverages the cache to retrieve videos from possible previous calls" do
        @cache.should_receive(:read).with("videos") { @videos }
        @service.latest_video
      end

      it "returns cached video data if there are some stored" do
        @cache.stub(:read) { @videos }
        @service.latest_video.should == :video1
      end

      it "does not download data from you tube if the cache has stored video data" do
        @cache.stub(:read) { @videos }
        @client.should_not_receive(:videos_by)
        @service.latest_video
      end   

      it "writes downloaded video data to the cache" do
        @client.stub(:videos_by) { @channel_info }
        @cache.should_receive(:write).with("videos", @videos, :expires_in => 12.hours)
        @service.latest_video
      end   
    end

    context "When retrieving recent videos" do
      it "gets all videos for lifesaglitchtv using the you tube client" do
        @client.should_receive(:videos_by).with(:user => 'lifesaglitchtv') { @channel_info }
        @service.recent_videos
      end

      it "returns videos 2 to 5 from the list of videos" do
        @client.stub(:videos_by) { @channel_info }
        @service.recent_videos.should == [:video2, :video3, :video4, :video5]
      end
    end
  end
end