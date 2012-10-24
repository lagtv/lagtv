require 'spec_helper'

describe UsersController do
  before do
    @ability = stub_abilities_for_controller
    @current_user = Fabricate.build(:member)
    @controller.stub(:current_user) { @current_user }
  end

  context "When editing a profile" do
    context "without permission" do
      before do
        @user = Fabricate.build(:member)
        @ability.cannot :edit, @user
        User.stub(:find) { @user }
        get :edit, { :id => "1" }
      end

      it { should redirect_to("http://test.host/") }
      it { should set_the_flash.to(:alert => "You do not have permission to access that page") }
    end

    context "with permission" do
      before do
        @ability.can :edit, @current_user
        get :edit
      end

      it { should respond_with(:success)}
    end
  end

  context "When showing the list of users" do
    context "without permission" do
      before do
        @ability.cannot :manage, User
        get :index
      end
      
      it { should redirect_to("http://test.host/") }
      it { should set_the_flash.to(:alert => "You do not have permission to access that page") }
    end

    context "with permission" do
      before do
        @ability.can :manage, User
      end

      context "rendering checks" do
        before do
          User.stub(:all_paged)
          get :index
        end

        it { should respond_with(:success) }
        it { should render_template(:index) }
        it { should_not set_the_flash } 
      end

      it "loads the user list" do
        params = { :page => "1", :query => "andy", :role => 'admin', :active => 'true' }
        User.should_receive(:all_paged).with(params)
        get :index, params
      end
    end
  end

  context "When showing register form" do
    before do
      @controller.stub(:current_user) { nil }
      get :new
    end

    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should assign_to(:is_human) }
  end

  context "When creating new user" do
    before do
      @user = Fabricate.build(:member)
      @user.role = "test"
      @params = { "email" => "test" }
      User.stub(:new) { @user }
    end

    def register
      post :create, { user: @params }
    end

    context "when the user isn't human" do
      before do
        IsHuman.should_receive(:correct?) { false } 
        register
      end

      it { should assign_to(:user) }
      it { should assign_to(:is_human) }
      it { should render_template(:new) }
      it { should set_the_flash.now.to(/we don't think you are human/i) }
    end

    context "when the user is human" do
      before do
        IsHuman.stub(:correct?) { true }
      end

      it "Creates new user" do
        User.should_receive(:new).with(@params) { @user }
        register
      end

      it "Sets the users role to member" do
        register
        @user.role.should == "member"
      end

      it "Sets the user to active" do
        register
        @user.active.should == true
      end

      it "Sets the users forum post initial state to approved" do
        register
        @user.forem_state.should == "approved"
      end

      context "with valid data" do
        before do
          @user.should_receive(:save) { true }
        end

        it "Sets session user id to new users id" do
          register
          cookies[:auth_token].should == @user.auth_token
        end

        it "Redirects to the home page if there is no redirect url in the session" do
          register
          should redirect_to root_url
        end

        it "Redirects to the home page if the stored referer is from a different domain" do
          session[:redirect_to] = "http://google.com/results"
          register
          should redirect_to root_url
        end

        it "Redirects to the url stored in the session" do
          session[:redirect_to] = "http://test.host/a/special/url"
          register
          should redirect_to "http://test.host/a/special/url"
        end

        it "Clears the session redirect url" do
          session[:redirect_to] = "/a/special/url"
          register
          session[:redirect_to].should == nil
        end

        it "Add a success message to the flash" do
          register
          should set_the_flash.to(/successfully/i)
        end
      end

      context "with invalid data" do
        before do
          @user.should_receive(:save) { false }
          register
        end

        it { should render_template(:new) }
      end
    end
  end
end