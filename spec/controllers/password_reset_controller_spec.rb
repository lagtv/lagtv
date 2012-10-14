require 'spec_helper'

describe PasswordResetController do
	context "When requesting to reset password" do
		before do
			get :new
		end

		it { should respond_with(:success) }
		it { should render_template(:new) }
	end

	context "When submitting new password reset request" do
		before do
			@user = Fabricate.build(:user)
			User.stub(:find_by_email) { @user }
		end

		def create_password_reset
			post :create, { :password_reset => {email: @user.email} }
		end

		it "Finds user by email address" do
			User.should_receive(:find_by_email).with(@user.email)
			create_password_reset
		end

		it "Calls send password reset for user" do
			@user.should_receive(:send_password_reset)
			create_password_reset
		end

		it "Redirects user back to the home page" do 
			create_password_reset
			should redirect_to root_url
		end

		it "Sets flash message to inform email has been sent" do
			create_password_reset
			should set_the_flash.to(/sent to reset/i)
		end
	end

	context "When viewing the password reset page" do
		before do
			@user = Fabricate.build(:user)
			User.should_receive(:find_by_password_reset_token!).with(@user.id.to_s) { @user }
			post :edit, { id: @user.id }
		end

		it { should respond_with(:success) }
		it { should render_template(:edit) }

	end

	context "When updating users password" do
		before do
			@user = Fabricate.build(:user)
			User.stub(:find_by_password_reset_token!) { @user }
		end

		it "finds user by password reset token" do
			User.should_receive(:find_by_password_reset_token!).with(@user.id.to_s) { @user }
			post :update, { id: @user.id }
		end

		it "Updates the user model" do
			@user.should_receive(:update_attributes)
			post :update, { id: @user.id }
		end

		context "updating user is successful" do
			before do
				@user.stub(:update_attributes) { true }
				post :update, { id: @user.id }
			end
			
			it { should redirect_to root_url }
			it { should set_the_flash.to(/successfully reset/i) }
		end

		context "updating user fails" do
			before do
				@user.stub(:update_attributes) { false }
				post :update, { id: @user.id }
			end

			it { should render_template(:edit) }
		end
	end
end
