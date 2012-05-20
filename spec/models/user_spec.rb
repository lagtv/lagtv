require 'spec_helper'

describe User do
  context "When validating a user" do
    before do
      @user = Fabricate(:user)
      Fabricate(:user, :email => "already@taken.com")
    end
    
    #it { @user.should validate_presence_of(:password) }
    it { @user.should ensure_length_of(:password).is_at_least(6) }
    it { @user.should validate_presence_of(:name) }
    it { @user.should validate_presence_of(:email) }
    it { @user.should validate_format_of(:email).with('someone@somewhere.com') }
    it { @user.should validate_format_of(:email).not_with('blah').with_message(/is not formatted properly/) }
    it { @user.should validate_uniqueness_of(:email) }
    it { @user.should allow_value("admin").for(:role) }
    it { @user.should allow_value("member").for(:role) }
    it { @user.should allow_value("community_manager").for(:role) }
    it { @user.should_not allow_value("god").for(:role) }
  end

  context "When loading a paged list of users" do
    it "paginates all users" do
      User.should_receive(:paginate).with(:page => 5, :per_page => 25)
      User.all_paged(5)
    end
  end

  context "When checking if a user is a(n)" do
    before do
      @user = Fabricate.build(:user)
    end

    context "admin" do
      before do
        @user.role = "admin"
      end      

      it "returns true for admin" do
        @user.admin?.should == true 
      end

      it "returns false for community manager" do
        @user.community_manager?.should == false
      end

      it "returns false for memeber" do
        @user.member?.should == false
      end
    end

    context "community manager" do
      before do
        @user.role = "community_manager"
      end      

      it "returns false for admin" do
        @user.admin?.should == false 
      end

      it "returns true for community manager" do
        @user.community_manager?.should == true
      end

      it "returns false for memeber" do
        @user.member?.should == false
      end
    end

    context "member" do
      before do
        @user.role = "member"
      end      

      it "returns false for admin" do
        @user.admin?.should == false 
      end

      it "returns false for community manager" do
        @user.community_manager?.should == false
      end

      it "returns true for memeber" do
        @user.member?.should == true
      end
    end
  end
end
