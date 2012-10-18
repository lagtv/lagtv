require 'spec_helper'

describe Ability do
  before do
    @admin = Fabricate.build(:admin)
    @community_manager = Fabricate.build(:community_manager)
    @member = Fabricate.build(:user)
    @moderator = Fabricate.build(:moderator)
  end
  
  context "When checking the abilities of an admin" do
    before do
      @admin_ability = Ability.new(@admin) 
    end
    
    it { @admin_ability.should be_able_to(:manage, :all) }
    it { @admin_ability.should be_able_to(:change_role, User) }
  end

  context "When checking the abilities of a community manager" do
    before do
      @community_manager_ability = Ability.new(@community_manager) 
    end
    
    it { @community_manager_ability.should be_able_to(:manage, User) }
    it { @community_manager_ability.should be_able_to(:manage, Replay) }
    it { @community_manager_ability.should be_able_to(:create, Comment) }
    it { @community_manager_ability.should_not be_able_to(:change_role, User) }
  end

  context "When checking the abilities of a member" do
    before do
      @member_ability = Ability.new(@member) 
      @members_replay = Fabricate.build(:replay, :user => @member)
      @another_members_replay = Fabricate.build(:replay)
    end
    
    it { @member_ability.should be_able_to(:create, @members_replay) }
    it { @member_ability.should_not be_able_to(:create, @another_members_replay) }
    it { @member_ability.should be_able_to(:create, Replay) }
    it { @member_ability.should_not be_able_to(:change_role, User) }
    it { @member_ability.should_not be_able_to(:manage, User) }
    it { @member_ability.should_not be_able_to(:manage, Replay) }
    it { @member_ability.should_not be_able_to(:create, Comment) }
  end

  context "When checking the abilities of a moderator" do
    before do
      @moderator_ability = Ability.new(@moderator) 
      @moderator_replay = Fabricate.build(:replay, :user => @moderator)
      @another_members_replay = Fabricate.build(:replay)
    end
    
    it { @moderator_ability.should be_able_to(:create, @moderator_replay) }
    it { @moderator_ability.should_not be_able_to(:create, @another_members_replay) }
    it { @moderator_ability.should be_able_to(:create, Replay) }
    it { @moderator_ability.should_not be_able_to(:change_role, User) }
    it { @moderator_ability.should_not be_able_to(:manage, User) }
    it { @moderator_ability.should_not be_able_to(:manage, Replay) }
    it { @moderator_ability.should_not be_able_to(:create, Comment) }
  end
end