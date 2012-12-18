require 'spec_helper'

describe Email do
  context "When validating a mail" do
    before do
      @mail = Fabricate(:mail)
    end

    it { @mail.should ensure_length_of(:subject).is_at_least(6) }
    it { @mail.should validate_presence_of(:subject) }
    it { @mail.should validate_presence_of(:body) }
    it { @mail.should validate_presence_of(:roles) }
  end

  context "When getting role_list" do
    it "should parse space-separated roles into an array" do
      @mail = Fabricate(:mail)
      groups = @mail.role_list
      groups.class.should == Array
      groups.length.should_not == 0
    end
  end
end
