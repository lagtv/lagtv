require 'youtube_it'

class HomeController < ApplicationController
  def index
    #cache = ActiveSupport::Cache::MemoryStore.new

    client = YouTubeIt::Client.new

    videos = cache_store.read("videos")
    unless videos
      videos = client.videos_by(:user => 'lifesaglitchtv').videos
      cache_store.write("videos", videos)
    end

    @latest_video = videos.first
    @videos = videos.take(5).slice(1..4)
  end
end