require 'acceptance/acceptance_helper'

feature 'Homepage renders' do

  background do
    visit '/'
  end

  scenario 'register button message appears' do
    page.should have_content('Send us your replays')
  end

  scenario 'starcraft tab' do
    page.should have_css('.tab', :text => 'LAGTV')
  end

  scenario 'the latest starcraft video' do
    page.should have_css(".lagtv1.latest_video")
  end

  scenario '4 recent starcraft videos' do
    debugger
    page.should have_css(".lagtv1 .video_thumbnail", :count=>24)
  end

  scenario 'lets play tab' do
    page.should have_css('.tab', :text => 'LAGTV2')
  end

  scenario 'the latest lets play video' do
    page.should have_css(".lagtv2.latest_video")
  end

  scenario '4 recent lets play videos' do
    debugger
    page.should have_css(".lagtv2 .video_thumbnail", :count=>24)
  end
end
