require 'spec_helper'

describe Announcement do
  context "When validating an announcement" do
    subject { Announcement.new }
    
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:starts_at) }
    it { should validate_presence_of(:ends_at) }
  end

  context "When returning a list of current announcements" do
    it "has current scope" do
      passed = Announcement.create! :starts_at => 1.day.ago, :ends_at => 1.hour.ago, :message => "passed"
      current = Announcement.create! :starts_at => 1.hour.ago, :ends_at => 1.day.from_now, :message => "current"
      upcoming = Announcement.create! :starts_at => 1.hour.from_now, :ends_at => 1.day.from_now, :message => "upcoming"
      Announcement.current.should eq([current])
    end

    it "does not include ids passed in to current" do
      current1 = Announcement.create! :starts_at => 1.hour.ago, :ends_at => 1.day.from_now, :message => "current"
      current2 = Announcement.create! :starts_at => 1.hour.ago, :ends_at => 1.day.from_now, :message => "current"
      Announcement.current([current2.id]).should eq([current1])
    end

    it "includes current when nil is passed in" do
      current = Announcement.create! :starts_at => 1.hour.ago, :ends_at => 1.day.from_now, :message => "current"
      Announcement.current(nil).should eq([current])
    end
  end
end
