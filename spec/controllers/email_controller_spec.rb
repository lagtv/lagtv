require 'spec_helper'

describe EmailController do
  before do
    @ability = stub_abilities_for_controller
  end

  describe "GET 'new'" do
    it "returns http success if admin" do
      @current_user = Fabricate.build(:admin)
      @controller.stub(:current_user) { @current_user }
      @ability.can :create, Email
      get 'new'
      response.should be_success
    end

    it "redirects if not admin" do
      @current_user = Fabricate.build(:member)
      @controller.stub(:current_user) { @current_user }
      @ability.cannot :create, Email
      get 'new'
      response.should be_redirect
    end
  end

  describe "POST 'create'" do
    before do
      @current_user = Fabricate.build(:admin)
      @controller.stub(:current_user) { @current_user }
      @ability.can :create, Email
    end

    it "returns http success if admin" do
      post 'create'
      response.should be_success
    end

    it "redirects if not admin" do
      @current_user = Fabricate.build(:member)
      @controller.stub(:current_user) { @current_user }
      @ability.cannot :create, Email
      post 'create'
      response.should be_redirect
    end

    #it "should prevent an email from being sent without roles" do
    #  post 'create'
    #  response.should be_success
    #end
  end
end
