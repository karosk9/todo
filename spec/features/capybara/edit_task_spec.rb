require 'rails_helper'

describe 'Edit task' do
  let!(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  include_examples 'not authenticated'

  context 'authenticated' do
    before(:each) do
      login_as(user)
    end

    it 'user can edit task' do
      visit ('/')
      expect(page).to have_content(task.description)
      click_on ('Edit')
      expect(page).to have_current_path("/tasks/#{task.id}/edit")
      expect(find_field('Description').value).to eq task.description
      fill_in 'Description', with: 'Do something else'
      click_on 'Update Task'
      expect(page).to have_current_path('/')
      expect(page).to have_content('Do something else')
    end
  end
end
