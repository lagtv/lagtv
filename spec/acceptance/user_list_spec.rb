require 'acceptance/acceptance_helper'

feature 'Users list' do

  background do
    4.times do
      Fabricate(:user)
    end
    Fabricate(:user, :name => 'MaximusBlack')
    visit '/users'
  end

  scenario 'title with count appears' do
    page.should have_content('5 Users')
  end

  scenario 'list all users' do
    page.should have_css("table tbody tr", :count => 5)
  end

  scenario 'search users' do
    fill_in 'query', :with => 'maximus'
    click_button 'Search'

    page.should have_css("table tbody tr", :count => 1)
    page.should have_css("table tbody tr", :text => 'MaximusBlack')
  end  
end