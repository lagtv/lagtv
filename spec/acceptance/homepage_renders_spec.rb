require 'acceptance/acceptance_helper'

feature 'Homepage renders' do

  scenario 'welcome message appears' do
    visit '/'
    page.should have_content('Welcome to LagTV!')
  end

end
