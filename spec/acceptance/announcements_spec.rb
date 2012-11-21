require 'acceptance/acceptance_helper'

feature 'Site announcements' do
  background do
    Announcement.create! :message => "Hello World", :url => 'http://blah.com', :starts_at => 1.hour.ago, :ends_at => 1.hour.from_now
    Announcement.create! :message => "Upcoming", :url => 'http://blah.com', :starts_at => 10.minutes.from_now, :ends_at => 1.hour.from_now
  end

  it "displays active announcements" do
    visit root_path
    page.should have_content "Hello World"
    page.should have_link "Hello World", :href => "http://blah.com"
  end

  it "doesn't display announcements where now is outside it's date range" do
    visit root_path
    page.should_not have_content "Upcoming"
  end

  it "hides an announcement from the user if they dismiss it" do
    visit root_path
    click_on "Hide this announcement"
    page.should_not have_content "Hello World"
  end
end

feature 'Site announcement admin' do
  background do
    Announcement.create! :message => "Hello World", :url => 'http://blah.com', :starts_at => 1.hour.ago, :ends_at => 1.hour.from_now
    @admin = Fabricate(:admin)
    login_as @admin
    visit root_path
    click_on "Announcements"
  end

  it 'lists site announcements' do
    page.should have_content "1 Announcement"
  end

  it 'adds new announcements' do
    click_on "Add Announcement"
    fill_in "Message", :with => "New upgrade now live!"
    fill_in "Url", :with => "http://blah.com"
    click_on "Save"
    page.should have_content '2 Announcements'
    page.should have_content 'Successfully scheduled the announcement'
  end

  it 'edits new announcements' do
    within "#announcement_list" do 
      click_on "Hello World"
    end

    fill_in "Message", :with => "Goodbye World"
    click_on "Save"
    page.should have_content '1 Announcement'
    page.should have_content 'Successfully updated the announcement'
    page.should_not have_content 'Hello World'
  end

  it 'deletes announcements' do
    click_on "Delete"
    page.should have_content '0 Announcements'
    page.should have_content 'Successfully deleted the announcement'
    page.should_not have_content 'Hello World'
  end
end

feature 'Access to announcements admin' do
  it "doesn't allow non-admins to access the announcements area" do
    member = Fabricate(:member)
    login_as member
    visit root_path
    page.should_not have_link 'Announcements'
  end
end