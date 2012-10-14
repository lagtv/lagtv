module HelperMethods
  def login_as(user)
    visit login_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Login'
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance