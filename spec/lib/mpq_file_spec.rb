require 'spec_helper'

describe MPQFile do
  context "When reading the version number from a replay file" do
    it "successfully parses a 1.4.3 file" do
      replay = MPQFile.new(File.expand_path('spec/acceptance/support/files/Good zerg win.SC2Replay'))
      replay.version.should == "1.4.3"
    end

    it "successfully parses a 2.0.10 file" do
      replay = MPQFile.new(File.expand_path('spec/acceptance/support/files/Akilon Wastes (53).SC2Replay'))
      replay.version.should == "2.0.10"
    end
  end

  context "When reading the length of the game" do
    it "returns the correctly formatted length" do
      replay = MPQFile.new(File.expand_path('spec/acceptance/support/files/Akilon Wastes (53).SC2Replay'))
      replay.length.should == "00:09:05"
    end

    it "returns the correct length in seconds" do
      replay = MPQFile.new(File.expand_path('spec/acceptance/support/files/Akilon Wastes (53).SC2Replay'))
      replay.length_in_seconds.should == 545
    end    
  end
end