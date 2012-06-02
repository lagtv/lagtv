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
    wcf = Fabricate(:category, :name => 'When cheese fails')
    normal = Fabricate(:category, :name => 'Normal Game')
    3.times do
      Fabricate(:replay, :category => wcf, :user => admin)
    end
    Fabricate(:replay, :title => 'super-duper 3v3 game replay', :players => '3v3', :category => wcf, :user => admin)
    Fabricate(:replay, :league => 'master', :title => 'Awesome Normal Game', :category => normal, :user => admin)
    Fabricate(:replay, :status => 'broadcasted', :category => wcf, :user => admin)
    Fabricate(:replay, :expires_at => DateTime.now.utc - 1.year, :category => wcf, :user => admin)

    login_as(admin)
    visit '/'
    click_link 'Replays'
  end

  scenario 'filter replays by category' do
    select 'Normal Game', :from => 'category_id'
    click_button 'Search'
    
    page.should have_css("table tbody tr", :count => 1)
    page.should have_css("table tbody tr", :text => 'Awesome Normal Game')
  end  

  scenario 'title with count appears' do
    page.should have_content('5 Replays')
  end

  scenario 'list all replays' do
    page.should have_css("table tbody tr", :count => 5)
  end

  scenario 'search replays' do
    fill_in 'query', :with => 'duper'
    click_button 'Search'

    page.should have_css("table tbody tr", :count => 1)
    page.should have_css("table tbody tr", :text => 'duper')
  end 

  scenario 'filter replays by league' do
    select 'Master', :from => 'league'
    click_button 'Search'

    page.should have_css("table tbody tr", :count => 1)
    page.should have_css("table tbody tr", :text => 'Master')
  end  

  scenario 'filter replays by players' do
    select '3v3', :from => 'players'
    click_button 'Search'

    page.should have_css("table tbody tr", :count => 1)
    page.should have_css("table tbody tr", :text => '3v3 game')
  end  

  scenario 'filter replays by status' do
    uncheck 'New'
    uncheck 'Suggested'
    uncheck 'Rejected'
    check 'Broadcasted'
    click_button 'Search'

    page.should have_css("table tbody tr", :count => 1)
    page.should have_css("table tbody tr", :text => 'Broadcasted')
  end    

  scenario 'include expired replays if selected' do
    check 'Include Expired Replays'
    click_button 'Search'

    page.should have_css("table tbody tr", :count => 6)
    page.should have_css("table tbody tr", :text => '(Expired)')
  end 
end