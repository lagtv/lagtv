require 'acceptance/acceptance_helper'

feature 'Replay list without permission' do
  scenario 'disallow access' do
    visit '/replays'
    page.should have_content('You do not have permission to access that page')
  end  

  scenario 'No link in menu' do
    visit '/'
    page.should_not have_link("Replays") 
  end  
end

feature 'Replay list with permission' do
  background do
    admin = Fabricate(:admin)

    login_as(admin)
    visit '/'
    click_link 'Replays'
  end

  scenario 'title with count appears' do
    page.should have_content('0 Replays')
  end
end