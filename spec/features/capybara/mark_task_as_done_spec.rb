require 'rails_helper'

describe 'Mark task as done' do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  include_examples 'not authenticated'

  context 'authenticated' do
    before(:each) do
      login_as(user)
    end

    it 'allows user to mark task as done' do
      visit '/'
      expect(page).to have_link('Done!')
      click_on 'Done'
      expect(page).to have_current_path('/')
      expect(page).to have_content('Restore')
      expect(page).to_not have_content('Done!')
    end

    context 'task is already marked as done' do
      let(:task) { create(:task, user: user, completed: true) }

      it "allows user to marks task as 'todo' again" do
        visit '/'
        expect(page).to have_link('Restore')
        click_on 'Restore'
        expect(page).to have_current_path('/')
        expect(page).to have_content('Done!')
        expect(page).to_not have_content('Restore')
      end
    end
  end
end
