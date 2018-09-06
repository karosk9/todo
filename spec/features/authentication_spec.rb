require 'rails_helper'

describe 'Authentication' do
  let(:user) { create(:user) }

  context 'not authenticated' do
    it 'allows users to log in' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_current_path('/')
      expect(page).to have_content('Log out')
      expect(page).to have_selector('#flash_success', text: 'Logged in successfully.')
    end
  end

  context 'authenticated' do
    before(:each) do
      login_as(user, scope: :user)
    end

    it 'allows user to log out' do
      visit root_path
      expect(page).to have_content('Log out')
      click_on 'Log out'
      expect(page).to have_current_path new_user_session_path
      expect(page).to have_selector('#flash_success', text: 'You need to sign in or sign up before continuing.')
      expect(page).to have_content('Log in')
    end
  end
end
