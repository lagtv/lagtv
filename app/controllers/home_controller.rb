class HomeController < ApplicationController
  def index
    lifesaglitchtv = YouTubeService.new('lifesaglitchtv', cache_store)
    lifesaglitchtv2 = YouTubeService.new('lifesaglitchtv2', cache_store)
    @lifesaglitchtv = lifesaglitchtv.channel
    @lifesaglitchtv2 = lifesaglitchtv2.channel
    
    if can? :create, Replay
      @replay = current_user.replays.build
      @categories = Category.all
    end
  end
end