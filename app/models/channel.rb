class Channel
  attr_accessor :latest_video, :recent_videos, :user_name

  def initialize(latest_video, recent_videos)
    @latest_video = latest_video
    @recent_videos = recent_videos
  end
end