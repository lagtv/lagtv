module HelperMethods
  def login_as(user)
    visit login_path
    fill_in 'email', :with => user.email
    fill_in 'password', :with => user.password
    click_button 'Login'
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance