require 'acceptance/acceptance_helper'

feature 'User Profile Page Renders' do
  background do
    user = Fabricate(:member)

    login_as(user)

    click_link('My Profile')
  end

  scenario 'save button message appears' do
    page.should have_css('.btn', :value => 'Save changes')
  end

  scenario 'users cannot change their own active state' do
    page.should_not have_css('input#user_active')
  end

  scenario 'users can change their own password' do
    page.should have_css('input#user_password')
  end
end