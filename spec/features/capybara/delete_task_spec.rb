require 'rails_helper'

describe 'Delete task' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: 'not_reqistered@email.com') }
  let(:task2) { create(:task, user: other_user, title: 'Should not be visable') }
  let(:task) { create(:task, user: user) }

  include_examples 'not authenticated'

  context 'authenticated' do
    before(:each) do
      login_as(user)
    end

    shared_examples 'user can delete task' do
      it 'acts correctly' do
        visit '/'
        expect(page).to have_content(task.title)
        expect(page).to_not have_content(task2.title)
        click_on 'Delete'
        expect(page).to have_current_path('/')
        expect(page).to_not have_content(task.title)
      end
    end

    context "task is marked as 'done!'" do
      let!(:task) { create(:task, user: user, completed: true) }
      include_examples 'user can delete task'
    end

    context "task is marked as 'Restore'" do
      let!(:task) { create(:task, user: user, completed: false) }
      include_examples 'user can delete task'
    end
  end
end
