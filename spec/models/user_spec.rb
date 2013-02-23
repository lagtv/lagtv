require 'spec_helper'

describe User do
  context "When populating profile urls" do
    it "takes the current username, lowercases it and replaces invalid chars" do
      user = Fabricate(:member, :name => "Andy The Great+15 'amazing!")

      User.populate_profile_urls

      User.pluck(:profile_url).should =~ ["andy_the_great_15__amazing_"]
    end

    it "adds a number if there are clashes after formatting the username" do
      user = Fabricate(:member, :name => "Logic")
      user = Fabricate(:member, :name => "logic")
      user = Fabricate(:member, :name => "logiC")

      User.populate_profile_urls

      User.pluck(:profile_url).should =~ ["logic", "logic1", "logic2"]
    end

    it "handles sql injection" do
      user = Fabricate(:member, :name => "Logic' or 1 = 1")

      User.populate_profile_urls

      User.pluck(:profile_url).should =~ ["logic__or_1___1"]
    end

    it "handles usernames that have a number at the end that were created first" do
      user = Fabricate(:member, :name => "Psymon1")
      user = Fabricate(:member, :name => "Psymon")
      
      User.populate_profile_urls

      User.order('created_at asc').pluck(:profile_url).should == ["psymon1", "psymon"]
    end
  end

  context "When finding a user using their email address" do
    before do
      @user = Fabricate(:member, :email => "blah@blah.com")
    end

    it "returns the user when the email matches exactly" do
      User.find_by_email('blah@blah.com').should == @user
    end

    it "returns the user when the email matches but the case is different to that stored" do
      User.find_by_email('Blah@Blah.Com').should == @user
    end

    it "returns nil if there is no user with the email address passed" do
      User.find_by_email('someone"somewhere.com').should == nil
    end
  end

  context "When checking user specific forem overrides" do
    before do
      @admin = Fabricate(:admin)
      @user = Fabricate(:member, :name => "Andy")
      @community_manager = Fabricate(:community_manager)
      @moderator = Fabricate(:moderator)
      @analyst = Fabricate(:analyst)
      @dev_team = Fabricate(:dev_team)
    end

    it "returns the users name if to_s is called on the user" do
      @user.to_s.should == "Andy"
    end

    it "allows admins to moderate forums" do
      @admin.can_moderate_forem_forum?(nil).should == true
      @admin.forem_admin?.should == true
    end

    it "allows community managers to moderate forums" do
      @community_manager.can_moderate_forem_forum?(nil).should == true
      @community_manager.forem_admin?.should == true
    end

    it "allows moderators to moderate forums" do
      @moderator.can_moderate_forem_forum?(nil).should == true
      @moderator.forem_admin?.should == true
    end

    it "allows dev team to moderate forums" do
      @dev_team.can_moderate_forem_forum?(nil).should == true
      @dev_team.forem_admin?.should == true
    end

    it "do not allow members to moderate forums" do
      @user.can_moderate_forem_forum?(nil).should == false
      @user.forem_admin?.should == false
    end

    it "do not allow analysts to moderate forums" do
      @analyst.can_moderate_forem_forum?(nil).should == false
      @analyst.forem_admin?.should == false
    end
  end

  context "When validating a user" do
    before do
      Fabricate(:member, :email => "already@taken.com")
    end

    subject do
      Fabricate(:member)
    end
    
    #it { should validate_presence_of(:password) }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:name) }
    
    it { should validate_presence_of(:profile_url) }
    it { should validate_uniqueness_of(:profile_url).case_insensitive }
    it { should validate_format_of(:profile_url).with('Bouse_76-LagTV') }
    it { should validate_format_of(:profile_url).not_with('this is invalid as a url +') }

    it { should validate_presence_of(:email) }
    it { should validate_format_of(:email).with('someone@somewhere.com') }
    it { should validate_format_of(:email).not_with('blah').with_message(/is not formatted properly/) }
    it { should validate_uniqueness_of(:email) }

    it { should allow_value("admin").for(:role) }
    it { should allow_value("member").for(:role) }
    it { should allow_value("community_manager").for(:role) }
    it { should allow_value("moderator").for(:role) }
    it { should allow_value("analyst").for(:role) }
    it { should_not allow_value("god").for(:role) }

    %w{facebook twitter twitch you_tube}.each do |service|
      it { should validate_format_of(service.to_sym).with('bLaH_-') }
      it { should validate_format_of(service.to_sym).not_with('some/ invalid chars') }
    end

    it "lower cases profile urls" do
      subject.profile_url = "ThisIsMixedCase"
      subject.save!
      subject.profile_url.should == "thisismixedcase"
    end
  end

  context "When building a service url" do
    it "returns nil if no service path is available" do
      user = User.new(:facebook => "", :twitter => "", :you_tube => "", :twitch => "")
      user.url_for_service(:facebook).should be_nil
      user.url_for_service(:twitter).should be_nil
      user.url_for_service(:you_tube).should be_nil
      user.url_for_service(:twitch).should be_nil
    end

    it "returns a url if the service path is available" do
      user = User.new(:facebook => "1", :twitter => "2", :you_tube => "3", :twitch => "4")
      user.url_for_service(:facebook).should == "http://facebook.com/1"
      user.url_for_service(:twitter).should == "http://twitter.com/2"
      user.url_for_service(:you_tube).should == "http://youtube.com/3"
      user.url_for_service(:twitch).should == "http://twitch.tv/4"
    end
  end

  context "When loading a paged list of users" do
    it "paginates all users" do
      User.should_receive(:paginate).with(:page => 5, :per_page => 25) { stub.as_null_object }
      User.all_paged(:page => 5)
    end

    context "and searching" do
      before do
        user1 = Fabricate(:admin, :name => 'Logic', :email => 'someone@somewhere.com')
        user2 = Fabricate(:member, :name => 'FxN', :email => 'someoneelse@somewhere.com')
        user3 = Fabricate(:member, :name => 'Danger', :email => 'blah@somewhere.com', :active => false)
      end

      it "returns all users when no search query is given" do
        User.all_paged(:page => 1, :active => '').count.should == 3
      end

      it "only returns matching name results" do
        User.all_paged(:query => "fxn").count.should == 1
      end

      it "only returns matching email results" do
        User.all_paged(:query => "someoneelse@somewhere.com").count.should == 1
      end

      it "only returns matching users by role" do
        User.all_paged(:role => "admin").count.should == 1
      end

      it "only returns matching users by active state" do
        User.all_paged(:active => 'true').count.should == 2
        User.all_paged(:active => 'false').count.should == 1
      end
    end
  end

  context "When checking if a user is a(n)" do
    before do
      @user = Fabricate.build(:member)
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

  context "When checking if a user has reached their weekly upload limit" do
    before do
      @user = Fabricate(:member)
      @category = Fabricate(:category)
    end

    it "returns false if no replays have been uploaded" do
      @user.reached_weekly_replay_limit?.should == false
    end

    it "returns true if 3 replays have been uploaded within the last 7 days" do
      3.times do 
        Fabricate(:replay, :user => @user, :category => @category, :created_at => 1.day.ago)
      end
      @user.reached_weekly_replay_limit?.should == true
    end

    it "returns false if the user has uploaded less than 3 replays within the last 7 days" do
      another_user = Fabricate(:member)
      Fabricate(:replay, :user => @user, :category => @category, :created_at => 1.day.ago)
      Fabricate(:replay, :user => @user, :category => @category, :created_at => 5.day.ago)
      Fabricate(:replay, :user => @user, :category => @category, :created_at => 8.day.ago)
      Fabricate(:replay, :user => another_user, :category => @category, :created_at => 1.day.ago)
      @user.reached_weekly_replay_limit?.should == false
    end
  end

  context "When building a new replay" do
    before do
      @user = Fabricate(:member)
      @replay = Fabricate.build(:replay, :status => '', :expires_at => DateTime.now.utc)
      @replays = double
      @replay_args = double
      @user.stub(:replays) { @replays }
      @user.stub(:reached_weekly_replay_limit?) { false }
      @replays.stub(:build) { @replay }
    end

    def do_call
      @user.build_replay(@replay_args)
    end

    it "instanciates a new replay with the supplied fields" do
      @replays.should_receive(:build).with(@replay_args) { @replay }
      do_call
    end

    it "returns the build replay" do
      do_call.should == @replay
    end

    it "sets the status of the replay to 'new'" do 
      do_call
      @replay.status.should == 'new'
    end

    it "sets the expiry of the replay 14 days time" do 
      do_call
      @replay.expires_at.to_i.should == (Time.now.utc + 14.days).to_i
    end   
    
    it "checks that the user has not breeched the weekly upload limit" do
      @user.should_receive(:reached_weekly_replay_limit?) { false }
      do_call
    end

    it "throws an expection if the user has breeched their weekly upload limit" do
      @user.stub(:reached_weekly_replay_limit?) { true }
      -> { do_call }.should raise_error
    end
  end

  context "When sending password reset email" do
    before do
      @user = Fabricate.build(:member)
      @user.stub(:save!)
      @mail = double
      UserMailer.stub(:password_reset).with(@user) { @mail }
      @mail.stub(:deliver)
    end

    it "creates a password reset token" do
      @user.should_receive(:generate_token).with(:password_reset_token)
      @user.send_password_reset
    end

    it "Saves the user object to store the reset token" do
      @user.should_receive(:save!)
      @user.send_password_reset
    end

    it "Calls user mailer to create the email" do
      UserMailer.should_receive(:password_reset).with(@user) { @mail }
      @user.send_password_reset
    end

    it "Calls deliver on the email to send it" do
      @mail.should_receive(:deliver)
      @user.send_password_reset
    end
  end

  context "When generating a secure token" do
    before do
      @user = Fabricate(:member)
    end

    it "Calls the SecureRandom base64 method" do
      SecureRandom.should_receive(:urlsafe_base64) { "test" }
      @user.generate_token(:password_reset_token)
    end

    it "Stores the generated value in the passed in column" do
      SecureRandom.stub(:urlsafe_base64) { "testerToken" }
      @user.generate_token(:auth_token)
      @user.auth_token.should == "testerToken"
    end
  end
end
