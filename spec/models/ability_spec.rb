require 'spec_helper'

describe Ability do
  before do
    @admin = Fabricate.build(:admin)
    @community_manager = Fabricate.build(:community_manager)
  end
  
  context "When checking the abilities of an admin" do
    before do
      @admin_ability = Ability.new(@admin) 
    end
    
    it { @admin_ability.should be_able_to(:view, :all) }
  end

  context "When checking the abilities of a community manager" do
    before do
      @community_manager_ability = Ability.new(@community_manager) 
    end
    
    it { @community_manager_ability.should be_able_to(:manage, User) }
  end
end