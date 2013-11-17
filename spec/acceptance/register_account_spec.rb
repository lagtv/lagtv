require 'acceptance/acceptance_helper'

feature 'Register user account' do

  background do
    visit "/"
    click_on "Register"
  end

  scenario 'shows the register page' do
    page.should have_content('Register new account')
  end

  scenario 'creates a new user account if all fields are valid' do
    fill_in_form
    solve_captcha
    click_button 'Register'

    page.should have_content("Registered successfully!")
  end

  scenario 'shows not human message if captcha fails' do
    fill_in_form
    click_button 'Register'

    page.should have_content("We don't think you are human, please try again.")
  end

  scenario 'shows validation errors if the human test passes but other fields have errors' do
    solve_captcha
    click_button 'Register'

    page.should have_content("can't be blank")
  end

  def fill_in_form
    fill_in 'Username', with: 'andypike'
    fill_in 'Email', with: 'someone@somewhere.com'
    fill_in 'Password', with: 'secret'
    fill_in 'Password confirmation', with: 'secret'
    fill_in 'Url', with: 'andypike'
  end

  def solve_captcha
    hash_in_form = find('#user_is_human_hash').value
    (4..20).each do |guess|
      hashed_guess = IsHuman.hash_answer(guess.to_words.downcase)
      fill_in 'user_is_human_attempt', with: guess if hashed_guess == hash_in_form
    end
  end

end
