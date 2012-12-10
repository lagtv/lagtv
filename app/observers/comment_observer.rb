class CommentObserver < ActiveRecord::Observer
  def after_save(comment)
    comment.replay.update_average_rating
  end
end