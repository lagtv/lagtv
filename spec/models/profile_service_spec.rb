require 'spec_helper'

describe ProfileService do
  context "When validating a category" do
    
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url_prefix) }
  end
end
