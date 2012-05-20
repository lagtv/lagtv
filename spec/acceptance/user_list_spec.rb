require 'acceptance/acceptance_helper'

feature 'Users list' do

  background do
    5.times do
      Fabricate(:user)
    end
    visit '/users'
  end

  scenario 'title with count appears' do
    page.should have_content('5 Users')
  end

  scenario 'list all users' do
    page.should have_css("table tbody tr", :count => 5)
  end
end