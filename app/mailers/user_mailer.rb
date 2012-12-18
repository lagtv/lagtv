class UserMailer < ActionMailer::Base
  default from: "no-reply@lag.tv"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset for LAGTV Website"
  end

  def group_message(subject, body, roles)
    users = User.find_all_by_role()
    mail :to => user.email, :subject => subject do |format|
      format.text { render :text => body }
    end
  end
end