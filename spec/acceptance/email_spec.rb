require 'acceptance/acceptance_helper'

feature 'Send an email to groups' do
  background do
    admin = Fabricate(:admin)
    login_as(admin)
    visit '/emails/new'
  end

  scenario 'email analysts and moderators' do
    page.should have_content('New Email')
    fill_in 'Subject', :with => 'Welcome to lag.tv'
    fill_in 'Body', :with => 'Hope you enjoy yourselves. Buy some schwag!'
    check 'Analysts'
    check 'Moderators'
    click_button 'Send'

    page.should have_content('Your email is being processed and sent')
  end

  scenario 'email without a role' do
    page.should have_content('New Email')
    fill_in 'Subject', :with => 'Welcome to lag.tv'
    fill_in 'Body', :with => 'Hope you enjoy yourselves. Buy some schwag!'
    click_button 'Send'

    page.should have_content('You must select at least one role')
  end

  scenario 'email as a member (who lacks permission)' do
    member = Fabricate(:member)
    login_as(member)
    visit '/emails/new'
    page.should have_content('You do not have permission to access that page')
  end  
end