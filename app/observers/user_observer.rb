class UserObserver < ActiveRecord::Observer
  def before_save(user)
    user.forem_admin = user.admin?  # Keep the forum admin permission in sync with the users role
    true
  end
end