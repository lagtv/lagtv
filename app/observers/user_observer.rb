class UserObserver < ActiveRecord::Observer
  def before_save(user)
    user.forem_admin = user.admin? || user.community_manager? || user.moderator?
    true
  end
end