class HomeController < ApplicationController
  def index
    lifesaglitchtv = YouTubeService.new('lifesaglitchtv', cache_store)
    @lifesaglitchtv = lifesaglitchtv.channel
  end
end