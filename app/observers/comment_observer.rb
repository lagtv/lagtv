class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    comment.replay.update_average_rating
  end
end