require 'spec_helper'

describe ProfileServiceInfo do
  context "When validating a profile service info instance" do
    
    it { should validate_presence_of(:username) }

    it "requires a url suffix if the service contains a url prefix" do
      subject.profile_service = ProfileService.new(:url_prefix => "http://blah.com")
      should validate_presence_of(:url_suffix)
    end

    it "allows a blank url suffix if no url prefix is specified" do
      subject.profile_service = ProfileService.new(:url_prefix => "")
      subject.username = "something"
      subject.url_suffix = ""

      subject.valid?.should be_true
    end
  end
end
