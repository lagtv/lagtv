require 'acceptance/acceptance_helper'

feature 'Category list without permission' do
  scenario 'disallow access' do
    visit categories_path
    page.should have_content('You do not have permission to access that page')
  end  

  scenario 'No link in menu' do
    visit root_path
    page.should_not have_link("Categories") 
  end  
end

feature 'Categories list with permission' do
  background do
    3.times do
      Fabricate(:category)
    end
    Fabricate(:category, :name => 'Big mac with cheese')
    admin = Fabricate(:admin, :name => 'Andy', :email => 'someone@somewhere.com', :password => 'secret', :password_confirmation => 'secret')

    login_as(admin)
    visit root_path
    click_link 'Categories'
  end

  scenario 'title with count appears' do
    page.should have_content('4 Categories')
  end

  scenario 'list all categories' do
    page.should have_css("table tbody tr", :count => 4)
  end

  scenario 'add a new category' do
    click_link 'Add Category'
    fill_in 'Name', :with => 'My new category'
    click_button 'Save'
    page.should have_css("td", :text => 'My new category')
  end

  scenario 'edit a category' do
    click_link 'Big mac with cheese'
    fill_in 'Name', :with => 'Quarter pounder with cheese'
    click_button 'Save'
    page.should have_css("td", :text => 'Quarter pounder with cheese')
  end
end