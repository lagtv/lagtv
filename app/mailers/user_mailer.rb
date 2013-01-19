class UserMailer < ActionMailer::Base
  default from: "no-reply@lag.tv"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset for LAGTV Website"
  end

  def group_message(email, recipient_address)
    puts "Sending email '#{email.subject}' to #{recipient_address}"
    message = mail :to => recipient_address, :subject => email.subject do |format|
      format.text { render :text => email.body }
    end
    
    email.update_attribute(:total_sent, email.total_sent + 1)
    email.update_attribute(:ended_at, Time.now) if email.done?

    message
  end
end

  # def group_message(email)
  #   begin
  #     users = User.where(:role => email.role)
      
  #     email.update_attribute(:started_at, Time.now)
  #     email.update_attribute(:total_recipients, users.count)

  #     users.each_with_index do |user, index|
  #       puts "Sending email '#{email.subject}' to #{user.email}"
  #       message = mail :to => user.email, :subject => email.subject do |format|
  #         format.text { render :text => email.body }
  #       end
  #       message.deliver
  #       email.update_attribute(:total_sent, index + 1)
  #     end
  #   rescue => e
  #     logger.fatal "Sending of group_message halted with exception #{e}."
  #   end

  #   email.update_attribute(:ended_at, Time.now)
  # end


# class UserMailer < ActionMailer::Base
#   MASS_EMAIL_STEPPING = 50
#   default from: "no-reply@lag.tv"

#   def password_reset(user)
#     @user = user
#     mail :to => user.email, :subject => "Password Reset for LAGTV Website"
#   end

#   def group_message(email)
#     begin
#       email.update_attribute(:started_at, Time.now)
#       count = 0
#       scope = User.where(:role => email.role)
#       total_users = scope.count

#       email.update_attribute(:total_recipients, total_users)
#       email.update_attribute(:ended_at, Time.now) if total_users == 0

#       while(count < total_users) do
#         email.update_attribute(:total_sent, count)
#         users = scope.order(:id).limit(MASS_EMAIL_STEPPING).offset(count)
#         users.each do |u|
#           mail :to => u.email, :subject => email.subject do |format|
#             format.text { render :text => email.body }
#           end
#           count += 1
#         end
#       end
#       email.update_attribute(:ended_at, Time.now) if count == total_users
#     rescue => e
#       logger.fatal "Sending of group_message halted with exception #{e}. Count is: #{count}"
#     end
#     email.update_attribute(:total_sent, count)
#   end
# end