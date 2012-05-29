class ReplaysController < ApplicationController
  def create
    @replay = Replay.new(params[:replay])
    @replay.user = current_user
    #authorize! :create, @replay
    
    if @replay.save
      redirect_to root_path, :notice => "Your replay was successfully uploaded. Thank you fellow bouse!"
    else
      render 'home/index'
    end
  end
end