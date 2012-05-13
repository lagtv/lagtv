require 'youtube_it'

class YouTubeService
  def initialize(user_name, cache)
    @cache = cache
    @user_name = user_name
    @client = YouTubeIt::Client.new
  end

  def latest_video
    all_videos.first
  end

  def recent_videos
    all_videos.take(5).slice(1..4)
  end

  def channel
    Channel.new(self.latest_video, self.recent_videos)
  end

private 
  def all_videos
    cache_key = "videos-#{@user_name}"
    videos = @cache.read(cache_key)
    unless videos
      videos = @client.videos_by(:user => @user_name).videos.sort { |a, b| b.published_at <=> a.published_at }
      @cache.write(cache_key, videos, :expires_in => 12.hours)
    end
    videos
  end
end