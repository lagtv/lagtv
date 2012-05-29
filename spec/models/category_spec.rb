require 'spec_helper'

describe Category do
  context "When validating a category" do
    before do
      @category = Fabricate(:category)
    end
    
    it { @category.should validate_presence_of(:name) }
  end
end
