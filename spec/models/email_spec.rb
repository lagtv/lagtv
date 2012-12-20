require 'spec_helper'

describe Email do
  context "When validating a mail" do
    before do
      @email = Fabricate(:email)
    end

    it { @email.should ensure_length_of(:subject).is_at_least(1).is_at_most(78) }
    it { @email.should ensure_length_of(:body).is_at_least(5) }
    it { @email.should validate_presence_of(:subject) }
    it { @email.should validate_presence_of(:body) }
    it { @email.should validate_presence_of(:roles) }
  end

  context "When getting role_list" do
    it "should parse space-separated roles into an array" do
      @email = Fabricate(:email)
      groups = @email.role_list
      groups.class.should == Array
      groups.length.should_not == 0
    end
  end

  context "Estimated time remaining string" do
    it "should estimate 20 minutes for 100 emails remaining at 5 a minute" do
      @email = Fabricate(:email, :started_at => Time.now - 1.minute, :ended_at => nil, :total_sent => 5, :total_recipients => 105)
      str = @email.estimated_completion_str
      str.should == "00:20"
    end

    it "should estimate 0 minutes for 0 emails remaining at 5 a minute" do
      @email = Fabricate(:email, :started_at => Time.now - 20.minute, :ended_at => Time.now, :total_sent => 100, :total_recipients => 100)
      str = @email.estimated_completion_str
      str.should == "00:00"
    end

    it "should estimate infinite minutes for 1 emails remaining at 0 a minute" do
      @email = Fabricate(:email, :started_at => Time.now, :ended_at => nil, :total_sent => 0, :total_recipients => 1)
      str = @email.estimated_completion_str
      str.should == "Never"
    end
  end

  context "Estimated send rate" do
    it "should estimate rate at 11 per second for 121 emails sent in 11 seconds" do
      @email = Fabricate(:email, :started_at => Time.now - 11.seconds, :ended_at => nil, :total_sent => 121)
      rate = @email.estimated_send_rate
      rate.should == 11
    end

    it "should estimate rate at 0 per second for 0 emails sent in 11 seconds" do
      @email = Fabricate(:email, :started_at => Time.now - 11.seconds, :ended_at => nil, :total_sent => 0)
      rate = @email.estimated_send_rate
      rate.should == 0
    end

    it "should estimate rate at 0 per second for 100 emails sent in 0 seconds" do
      now = Time.now
      Time.stub(:now) { now }
      @email = Fabricate(:email, :started_at => Time.now, :ended_at => nil, :total_sent => 100)
      rate = @email.estimated_send_rate
      rate.should == 0
    end
  end
end
