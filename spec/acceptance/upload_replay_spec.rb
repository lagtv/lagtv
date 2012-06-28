require 'acceptance/acceptance_helper'

feature 'Non-logged in users should not be able to upload replays' do
  scenario "user doesn't see the upload controls" do
    visit '/'
    page.should_not have_content('Please complete the form below to upload a replay file for casting.')
  end  
end

feature 'Allow logged in members to upload replay files for review' do
  background do
    member = Fabricate(:user)
    Fabricate(:category, :name => 'When cheese fails')

    login_as(member)
    visit '/'
  end

  scenario 'user should see the upload controls' do
    page.should have_content('Please complete the form below to upload a replay file for casting.')
  end

  scenario 'submitting a valid form should successfully upload the replay' do
    attach_file "Replay file", File.expand_path('spec/acceptance/support/files/Good zerg win.SC2Replay')
    select 'When cheese fails', :from => 'Category'
    select 'Silver', :from => 'League'
    select '1v1', :from => 'Players'
    check 'Zerg'
    check 'Protoss'
    fill_in 'Title', :with => 'Awesome win against zerg'
    fill_in 'Description', :with => 'Nice win against zerg which we all know is impossible!'
    click_button 'Upload Replay'

    page.should have_content('Your replay was successfully uploaded.')
  end  
end