require 'spec_helper'

describe UsersController do
  context "When showing the list of users" do
    before do
      get :index
    end

    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should_not set_the_flash } 
  end
end