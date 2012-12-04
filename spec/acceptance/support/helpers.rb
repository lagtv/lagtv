module HelperMethods
  def login_as(user)
    unless user.nil?
      visit login_path
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Login'
    end
  end

  def truthify(&block)
    begin
      yield
      return true
    rescue
      return false
    end
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance