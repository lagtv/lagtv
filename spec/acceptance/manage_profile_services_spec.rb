require 'acceptance/acceptance_helper'

feature 'Profile services list without permission' do
  scenario 'disallow access' do
    visit profile_services_path
    page.should have_content('You do not have permission to access that page')
  end  

  scenario 'No link in menu' do
    visit root_path
    page.should_not have_link("Profile Services") 
  end  
end

feature 'Profile services list with permission' do
  background do
    @profile_service = Fabricate(:profile_service)
    admin = Fabricate(:admin)

    login_as(admin)
    visit root_path
    click_link 'Profile Services'
  end

  scenario 'title with count appears' do
    page.should have_content('1 Profile Service')
  end

  scenario 'list all services' do
    page.should have_css("table tbody tr", :count => 1)
  end
end

feature 'Adding a new profile service' do
  background do
    admin = Fabricate(:admin)

    login_as(admin)
    visit root_path
    click_link 'Profile Services'
  end

  scenario 'successfully adds a service if the form is valid' do
    click_link 'Add Profile Service'
    fill_in 'Name', :with => 'Battle.net'
    fill_in 'Url prefix', :with => 'http://blah/{username}'
    attach_file "Logo", File.expand_path('spec/acceptance/support/files/logo.png')

    click_button 'Save'
    page.should have_css("td", :text => 'Battle.net')
    page.should have_content "Profile Service added successfully"
  end

  scenario 'shows errors if the form is invalid' do
    click_link 'Add Profile Service' 
    click_button 'Save'
    page.should have_content "can't be blank"
  end
end

feature 'Editing an existing profile service' do
  background do
    admin = Fabricate(:admin)
    Fabricate(:profile_service, :name => "Battle.net")

    login_as(admin)
    visit root_path
    click_link 'Profile Services'
  end

  scenario 'successfully adds a service if the form is valid' do
    click_link 'Battle.net'
    fill_in 'Name', :with => 'Battle.net2'
    fill_in 'Url prefix', :with => 'http://blah/{username}'
    attach_file "Logo", File.expand_path('spec/acceptance/support/files/logo.png')

    click_button 'Save'
    page.should have_css("td", :text => 'Battle.net2')
    page.should have_content "Profile Service updated successfully"
  end

  scenario 'shows errors if the form is invalid' do
    click_link 'Battle.net'
    fill_in 'Name', :with => ''
    click_button 'Save'
    page.should have_content "can't be blank"
  end
end