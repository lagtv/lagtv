class UserObserver < ActiveRecord::Observer
  def before_save(user)
    user.forem_admin = user.admin?

    true
  end
end