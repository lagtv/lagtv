class UserMailer < ActionMailer::Base
  MASS_EMAIL_STEPPING = 50
  default from: "no-reply@lag.tv"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset for LAGTV Website"
  end

  def group_message(email)
    email.update_attribute(:started_at, Time.now)
    sample_mail = nil
    count = 0
    scope = User.scoped
    email.role_list.each{ |r| scope.send(r) }
    total_users = scope.count

    email.update_attribute(:total_recipients, total_users)
    email.update_attribute(:ended_at, Time.now) if total_users == 0

    while(count < total_users) do
      email.update_attribute(:total_sent, count)
      users = User.send(email.roles).order(:id).limit(MASS_EMAIL_STEPPING).offset(count)
      users.each do |u|
        sample_mail = mail :to => u.email, :subject => email.subject do |format|
          format.text { render :text => email.body }
        end
        count += 1
      end
    end
    email.update_attribute(:ended_at, Time.now) if count == total_users
    sample_mail
  ensure
    email.update_attribute(:total_sent, count)
  end
end