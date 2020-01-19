require 'rails_helper'

describe 'Sign up' do
  include_examples 'not authenticated'

  it 'user sets up an account' do
    visit '/'
    expect(page).to have_current_path('/users/login')
    click_link 'Sign up'
    expect(page).to have_current_path('/users/sign_up')
    fill_in 'Email', with: 'user@example.com'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_current_path('/')
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Log out')
  end
end
