require 'acceptance/acceptance_helper'

feature 'Homepage renders' do

  scenario 'upload button message appears' do
    visit '/'
    page.should have_content('Upload')
  end

end
