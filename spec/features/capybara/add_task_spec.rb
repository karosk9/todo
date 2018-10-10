require 'rails_helper'

describe 'user creates task' do
let(:user) { create(:user) }

  include_examples 'not authenticated'

  context 'authenticated' do
    before(:each) do
      login_as(user)
    end

    it 'Enters New Task page' do
      visit ('/')
      expect(page).to have_content('New')
      click_on ('New')
      expect(page).to have_current_path('/tasks/new')
      expect(page).to have_content('New Task')
    end

    it 'Adds a new task' do
      visit ('/tasks/new')
      fill_in 'Title', with: 'Pay bills'
      click_on ('Create Task')
      expect(page).to have_current_path('/')
      expect(page).to have_content('Task was successfully created')
      expect(page).to have_content('Pay bills')
    end
  end
end
