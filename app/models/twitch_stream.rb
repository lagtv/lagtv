require "net/https"

class TwitchStream
  attr_reader :stream

  def initialize (stream)
    @stream = stream
  end

  def live?
    uri = URI("https://api.twitch.tv/kraken/streams/#{stream.username}")
    response = ""
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      response = http.request(request).body
    end
    JSON.parse(response)["stream"].present?
  rescue
    false
  end
end
