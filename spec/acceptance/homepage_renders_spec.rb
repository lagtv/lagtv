require 'acceptance/acceptance_helper'

feature 'Homepage renders' do

  background do
    visit '/'
  end

  scenario 'register button message appears' do
    page.should have_content('Register')
  end

  scenario 'login button message appears' do
    page.should have_content('Login')
  end

  scenario 'starcraft tab' do
    page.should have_css('.nav-tabs', :text => 'StarCraft')
  end

  scenario 'the latest starcraft video' do
    page.should have_css("#starcraft .latest_video")
  end

  scenario '4 recent starcraft videos' do
    page.should have_css("#starcraft .recent", :count=>4)
  end

  scenario 'minecraft tab' do
    page.should have_css('.nav-tabs', :text => 'Minecraft')
  end

  scenario 'the latest minecraft video' do
    page.should have_css("#minecraft .latest_video")
  end

  scenario '4 recent minecraft videos' do
    page.should have_css("#minecraft .recent", :count=>4)
  end
end
