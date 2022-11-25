require 'rails_helper'

RSpec.feature 'Logins', type: :feature do
  background { visit new_user_session_path }

  scenario 'with valid information' do
    page.fill_in placeholder: 'Enter your email', with: 'johnson@example.com'
    page.fill_in placeholder: 'Enter password', with: 'password'

    click_button 'Log in'
    visit categories_path
  end

  scenario 'with invalid information' do
    page.fill_in placeholder: 'Enter your email', with: 'johnson@example.com'
    page.fill_in placeholder: 'Enter password', with: 'pass'

    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
