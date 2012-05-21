require 'spec_helper'

describe UsersController do
  context "When showing the list of users" do
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
      User.should_receive(:all_paged).with("1", "andy", 'admin')
      get :index, { :page => "1", :query => "andy", :role => 'admin' }
    end
  end

  context "When showing register form" do
    before do
      get :new
    end

    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  context "When creating new user" do
    before do
      @user = Fabricate.build(:user)
      @user.role = "test"
      @params = { "email" => "test" }
      User.stub(:new) { @user }
    end

    def register
      post :create, { user: @params }
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

    context "with valid data" do
      before do
        @user.should_receive(:save) { true }
        register
      end

      it "Sets session user id to new users id" do
        session[:user_id].should == @user.id
      end

      it { should redirect_to root_url }
      it { should set_the_flash.to(/successfully/i) }
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