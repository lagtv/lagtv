require 'ostruct'

class UserMailer < ActionMailer::Base
  default from: "LAGTV <no-reply@lag.tv>"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset for LAGTV Website"
  end

  def group_message(email, recipient_address)
    mail :to => recipient_address, :subject => email.subject do |format|
      format.text { render :text => email.body }
    end
  end

  def report_profile(report)
    @report = OpenStruct.new(report)
    mail :to => 'community@lag.tv', :subject => "Profile reported"
  end
end