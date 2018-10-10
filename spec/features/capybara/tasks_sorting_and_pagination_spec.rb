require 'rails_helper'

describe 'Sorting and pagination' do
  let(:user) { create(:user) }
  let!(:task1) { create(:task, user: user, title: 'Old task', created_at: DateTime.now - 2.days) }
  let!(:task2) { create(:task, user: user, title: 'New task', created_at: DateTime.now) }
  let!(:tasks) { create_list(:task, 25, user: user, created_at: DateTime.now - 1.day) }

  before do
    login_as(user)
  end

  context 'first page' do
    it 'sorts tasks by the creation date and shows first 20' do
      visit ('/')
      expect(page).to have_content('Total ToDo: 27')
      expect(page).to have_content('New task')
      expect(page).not_to have_content('Old task')
      expect(Task.page.count).to eq(20)
    end
  end

  context 'second page' do
    it 'sorts tasks by the creation date and shows last 7' do
      visit ('/')
      click_on 'Next ›'
      expect(page).to have_content('Total ToDo: 27')
      expect(page).not_to have_content('New task')
      expect(page).to have_content('Old task')
    end
  end
end
