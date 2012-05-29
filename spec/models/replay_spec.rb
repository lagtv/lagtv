require 'spec_helper'

describe Replay do
  context "When validating a replay" do
    before do
      @replay = Fabricate(:replay, :category => Fabricate(:category), :user => Fabricate(:user))
    end
    
    it { @replay.should validate_presence_of(:title) }
    #it { @replay.should validate_presence_of(:replay_file) }
    it { @replay.should validate_presence_of(:category_id) }
    it { @replay.should validate_presence_of(:user_id) }

    it { @replay.should validate_presence_of(:players) }    
    it { @replay.should allow_value("1v1").for(:players) }
    it { @replay.should allow_value("2v2").for(:players) }
    it { @replay.should allow_value("3v3").for(:players) }
    it { @replay.should allow_value("4v4").for(:players) }
    it { @replay.should allow_value("FFA").for(:players) }
    it { @replay.should_not allow_value("blah").for(:players) }

    it { @replay.should validate_presence_of(:league) }
    it { @replay.should allow_value("bronze").for(:league) }
    it { @replay.should allow_value("silver").for(:league) }
    it { @replay.should allow_value("gold").for(:league) }
    it { @replay.should allow_value("platinum").for(:league) }
    it { @replay.should allow_value("diamond").for(:league) }
    it { @replay.should allow_value("master").for(:league) }
    it { @replay.should allow_value("grand_master").for(:league) }
    it { @replay.should_not allow_value("blah").for(:league) }
  end
end
