require 'spec_helper'

describe Ability do
  before do
    @admin = Fabricate.build(:admin)
  end
  
  context "When checking the abilities of a member" do
    before do
      @ability = Ability.new(@admin) 
    end
    
    it { @ability.should be_able_to(:view, :all) }
  end
end