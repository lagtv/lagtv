require "net/https"

class HitboxStream
  attr_reader :stream

  def initialize (stream)
    @stream = stream
  end

  def live?
    uri = URI("https://api.hitbox.tv/media/live/#{stream.username}")
    response = ""
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      response = http.request(request).body
    end
    JSON.parse(response)["livestream"][0]["media_is_live"] == "1"
  rescue
    false
  end
end
