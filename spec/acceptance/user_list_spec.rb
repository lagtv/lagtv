require 'acceptance/acceptance_helper'

feature 'Users list without permission' do
  scenario 'disallow access' do
    visit '/users'
    page.should have_content('You do not have permission to access that page')
  end  

  scenario 'No link in menu' do
    visit '/'
    page.should_not have_link("Users") 
  end  
end

feature 'Users list with permission' do
  background do
    4.times do
      Fabricate(:user)
    end
    Fabricate(:user, :name => 'MaximusBlack')
    admin = Fabricate(:admin, :name => 'Andy', :email => 'someone@somewhere.com', :password => 'secret', :password_confirmation => 'secret')

    login_as(admin)
    visit '/'
    click_link 'Users'
  end

  scenario 'title with count appears' do
    page.should have_content('6 Users')
  end

  scenario 'list all users' do
    page.should have_css("table tbody tr", :count => 6)
  end

  scenario 'search users' do
    fill_in 'query', :with => 'maximus'
    click_button 'Search'

    page.should have_css("table tbody tr", :count => 1)
    page.should have_css("table tbody tr", :text => 'MaximusBlack')
  end  

  scenario 'filter users by role' do
    select 'Admin', :from => 'role'
    click_button 'Search'

    page.should have_css("table tbody tr", :count => 1)
    page.should have_css("table tbody tr", :text => 'Andy')
  end    
end