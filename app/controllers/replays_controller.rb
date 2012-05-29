class ReplaysController < ApplicationController
  def new

  end

  def create
    @replay = current_user.replays.build(params[:replay])
    authorize! :create, @replay

    if @replay.save
       redirect_to root_path, :notice => "Your replay was successfully uploaded. Thank you fellow bouse!"
    else
       render 'new'
    end
  end
end