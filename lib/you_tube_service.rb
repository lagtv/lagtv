class YouTubeService
  def initialize(cache)
    @cache = cache
    @client = YouTubeIt::Client.new
  end

  def latest_video
    all_videos.first
  end

  def recent_videos
    all_videos.take(5).slice(1..4)
  end

private 
  def all_videos
    videos = @cache.read("videos")
    unless videos
      videos = @client.videos_by(:user => 'lifesaglitchtv').videos
      @cache.write("videos", videos, :expires_in => 12.hours)
    end
    videos
  end
end