class ReplaysController < ApplicationController
  def new

  end

  def create
    @replay = current_user.replays.build(params[:replay])
    @replay.status = 'new'
    # TODO: check that the user has not already uploaded 3 replays this week
    authorize! :create, @replay

    if @replay.save
       redirect_to root_path, :notice => "Your replay was successfully uploaded. Thank you fellow bouse!"
    else
       render 'new'
    end
  end
end