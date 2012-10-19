require "spec_helper"

describe UserMailer do
  context "When sending password reset email" do
    before do
      @user = Fabricate.build(:member)
      @user.password_reset_token = "testToken"
      @mail = UserMailer.password_reset(@user)
    end

    it "Sets correct subject line for the email" do
      @mail.subject.should eq("Password Reset for LAGTV Website")
    end

    it "Sends the email to the users email address" do
      @mail.to.should eq([@user.email])
    end

    it "Sets the from address for the email" do
      @mail.from.should eq(["no-reply@lagtvwebsite"])
    end
  end

end
