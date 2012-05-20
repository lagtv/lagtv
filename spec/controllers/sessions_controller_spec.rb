require 'spec_helper'

describe SessionsController do
	context "When showing login form" do
		before do
			get :new
		end
		it { should respond_with(:success) }
		it { should render_template(:new) }
	end

	context "When logging in" do
		before do
			@user = Fabricate.build(:user)
		end

		def login
			post :create, { email: @user.email, password: @user.password }
		end

		context "An existing user" do
			before do
				User.stub(:find_by_email) { @user }
			end

				context "With correct password" do
					before do
						@user.stub(:authenticate) { true }
					end

				it "Finds user by email" do
					User.should_receive(:find_by_email).with(@user.email) { @user }
					login
				end

				it "Authenticates user with passed in password" do
					@user.should_receive(:authenticate).with(@user.password) { true }
					login
				end

				it "Sets current user id to the session variable" do
					login
					session[:user_id].should == @user.id
				end

				it "Redirects to the home page" do
					login
					should redirect_to root_url
				end

				it "Sets the flash message to success" do
					login
					should set_the_flash.to(/success/i)
				end
			end

			context "With wrong password" do
				before do
					@user.stub(:authenticate) { false }
					login
				end

				it { should set_the_flash.to(/invalid/i) }
				it { should render_template(:new) }

			end
		end

		context "Non existing user" do
			before do
				User.stub(:find_by_email) { nil }
				login
			end

			it { should set_the_flash.to(/invalid/i) }
			it { should render_template(:new) }

		end

		context "User that has been disabled" do
			before do
				User.stub(:find_by_email) { @user }
				@user.stub(:authenticate) { true }
				@user.active = false
				login
			end

			it { should set_the_flash.to(/disabled/i) }
			it { should render_template(:new) }
		end
	end

	context "When logging out" do
		before do
			session[:user_id] = "test"
			get :destroy
		end

		it "Clears the current user" do
			session[:user_id].should == nil
		end

		it { should redirect_to root_url }
		it { should set_the_flash.to(/out/i) }

	end
end
