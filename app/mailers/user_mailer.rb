class UserMailer < ActionMailer::Base
  MASS_EMAIL_STEPPING = 50
  default from: "no-reply@lag.tv"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset for LAGTV Website"
  end

  def group_message(email)
    count = 0
    total_users = User.send(email.roles).count

    while(count < total_users) do
      users = User.send(email.roles).limit(MASS_EMAIL_STEPPING)
      users.each do |u|
        mail :to => user.email, :subject => email.subject do |format|
          format.text { render :text => email.body }
        end
        count += 1
      end
    end
  ensure
    email.update_attribute(:total_sent, count)
  end
end