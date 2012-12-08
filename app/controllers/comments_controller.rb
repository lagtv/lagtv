class CommentsController < ApplicationController
  def create
    authorize! :create, Comment
    replay = Replay.find(params[:replay_id])
    comment = replay.comments.build(params[:comment])
    comment.user = current_user

    if comment.save
      redirect_to edit_replay_path(replay), :notice => 'Your comment was added successfully'
    else
      redirect_to edit_replay_path(replay), :alert => "Adding your comment failed: #{comment.errors.full_messages.to_sentence}"
    end
  end

  def index
    authorize! :view, Comment
    @replay = Replay.find(params[:replay_id])
    @comments = @replay.comments.paginate(:page => params[:page], :per_page => 5)
    render :partial => 'page', :layout => false
  end

  def edit
    @replay = Replay.find(params[:replay_id])
    @comment = Comment.find(params[:id])
  end
end