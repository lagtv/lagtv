class ReplaysController < ApplicationController
  def new
    authorize! :create, Replay
    @replay = current_user.replays.build
    @categories = Category.ordered
  end

  def create
    @replay = current_user.build_replay(params[:replay])
    authorize! :create, @replay

    if @replay.save
      redirect_to root_path, :notice => "Your replay was successfully uploaded. Thank you fellow bouse!"
    else
      @categories = Category.ordered
      render 'new'
    end
  end

  def index
    authorize! :manage, Replay
    @replays = Replay.all_paged(params.slice(*Replay::DEFAULT_FILTERS.keys).symbolize_keys)
    @filters = params.reverse_merge(Replay::DEFAULT_FILTERS)
    @categories = Category.ordered
  end

  def edit
    @replay = Replay.find(params[:id])
    authorize! :edit, @replay
    @categories = Category.ordered
  end

  def update
    @replay = Replay.find(params[:id])
    authorize! :edit, @replay
    if @replay.update_attributes(params[:replay])
       redirect_to replays_path, :notice => 'You have successfully updated the replay.'
    else
      @categories = Category.ordered
      render 'edit'
    end
  end
end