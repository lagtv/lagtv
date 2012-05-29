require 'acceptance/acceptance_helper'

feature 'User Profile Page Renders' do
  background do
    user = Fabricate(:user)

    login_as(user)

    click_link('My Profile')
  end

  scenario 'save button message appears' do
    page.should have_css('.btn', :value => 'Save changes')
  end
end