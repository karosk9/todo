require 'rails_helper'

describe 'user creates task' do
  let(:user) { create(:user) }

  include_examples 'not authenticated'

  context 'authenticated' do
    before(:each) do
      login_as(user)
    end

    it 'Enters New Task page' do
      visit '/'
      expect(page).to have_content('New')
      click_on 'New'
      expect(page).to have_current_path('/tasks/new')
      expect(page).to have_content('New Task')
    end

    context 'Adds a new task' do
      before { visit '/tasks/new' }

      after do
        expect(page).to have_current_path('/')
        expect(page).to have_content('Task was successfully created')
      end

      it 'has title and content' do
        fill_in 'Title', with: 'Pay bills'
        fill_in 'Content', with: 'The sooner the better'
        click_on 'Create Task'
        expect(page).to have_content('Pay bills')
        expect(page).to have_content('The sooner the better')
      end

      it 'has not title' do
        click_on 'Create Task'
        expect(page).to have_content('No title')
      end
    end
  end
end
