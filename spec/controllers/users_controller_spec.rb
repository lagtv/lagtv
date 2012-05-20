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
      User.should_receive(:all_paged).with("1")
      get :index, { :page => "1" }
    end
  end
end