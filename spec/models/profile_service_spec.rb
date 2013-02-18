require 'spec_helper'

describe ProfileService do
  context "When validating a profile service" do
    
    it { should validate_presence_of(:name) }
  end
end
