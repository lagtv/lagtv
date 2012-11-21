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
    page.should_not have_content("Hello World")
  end
end

feature 'Site announcement admin' do
  background do
    Announcement.create! :message => "Hello World", :url => 'http://blah.com', :starts_at => 1.hour.ago, :ends_at => 1.hour.from_now
    @admin = Fabricate(:admin)
    login_as @admin
    visit root_path
  end

  it 'lists site announcements' do
    click_on "Announcements"
    page.should have_content("1 Announcement")
  end
end