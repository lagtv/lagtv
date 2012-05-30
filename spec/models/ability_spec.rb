require 'spec_helper'

describe Ability do
  before do
    @admin = Fabricate.build(:admin)
    @community_manager = Fabricate.build(:community_manager)
    @member = Fabricate.build(:user)
  end
  
  context "When checking the abilities of an admin" do
    before do
      @admin_ability = Ability.new(@admin) 
    end
    
    it { @admin_ability.should be_able_to(:manage, :all) }
  end

  context "When checking the abilities of a community manager" do
    before do
      @community_manager_ability = Ability.new(@community_manager) 
    end
    
    it { @community_manager_ability.should be_able_to(:manage, User) }
    it { @community_manager_ability.should be_able_to(:manage, Replay) }
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
  end
end