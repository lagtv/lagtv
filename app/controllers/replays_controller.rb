class ReplaysController < ApplicationController
  def new
    authorize! :create, Replay
    @replay = current_user.replays.build
    @categories = Category.all
  end

  def create
    @replay = current_user.build_replay(params[:replay])
    authorize! :create, @replay

    if @replay.save
      redirect_to root_path, :notice => "Your replay was successfully uploaded. Thank you fellow bouse!"
    else
      @categories = Category.all
      render 'new'
    end
  end

  def index
    authorize! :manage, Replay
    @replays = Replay.all_paged(params.slice(:page).symbolize_keys)
  end
end