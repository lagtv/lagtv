require 'youtube_it'

class HomeController < ApplicationController
  def index
    puts cache_store
    
    you_tube = YouTubeService.new(cache_store)
    @latest_video = you_tube.latest_video
    @videos = you_tube.recent_videos
  end
end