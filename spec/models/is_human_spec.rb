require 'spec_helper'

describe IsHuman do
  before do
    @is_human = IsHuman.new
  end

  it "generates three random numbers between 2 and 10" do
    @is_human.first.should be_between(2, 10)
    @is_human.second.should be_between(2, 10)
    @is_human.third.should be_between(2, 10)
  end

  it "selects two categories that do not equal each other" do
    @is_human.primary_category.should match /flowers|fruit|animals|clothes/
    @is_human.secondary_category.should match /flowers|fruit|animals|clothes/
    @is_human.primary_category.should_not == @is_human.secondary_category
  end

  it "generates a question" do
    @is_human.question.should == ""
  end
end