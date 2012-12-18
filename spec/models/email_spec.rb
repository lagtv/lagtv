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
end
