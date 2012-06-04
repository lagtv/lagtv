require 'acceptance/acceptance_helper'

feature 'Replay list with permission' do
  background do
    admin = Fabricate(:admin)
    awesome_replay = Fabricate(:replay, :title => "My Awesome Replay")
    other_replay = Fabricate(:replay, :title => "Another Replay")
    Fabricate(:comment, :text => "Awesome comment", :replay => awesome_replay)
    Fabricate(:comment, :text => "Another comment", :replay => other_replay)
  
    login_as(admin)
    visit '/'
    click_link 'Replays'
    click_link 'My Awesome Replay'
  end

  scenario 'show list of comments' do
    page.should have_content("Awesome comment")
    page.should_not have_content("Another comment")
  end  
end