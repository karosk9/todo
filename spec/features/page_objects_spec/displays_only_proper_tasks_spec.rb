require 'rails_helper'

describe 'New Task' do
  let(:new_task_page) { NewTaskPage.new }
  let(:index_page) { IndexPage.new }
  let(:user) { create(:user, email: 'user@example.com') }
  let(:user2) { create(:user, email: 'user2@example.com') }
  let!(:task) { create(:task, user: user, description: 'task 1') }
  let!(:task2) { create(:task, user: user2, description: 'task 2') }
  let!(:task3) { create(:task, user: user, description: 'task 3') }

  before do
    login_as(user)
    index_page.load
  end

  it "displays only signed in user's tasks" do
    expect(current_path).to eq(index_page.url)
    expect(index_page.tasks.count).to eq(2)
    expect(index_page).to have_content(user.email)
    expect(index_page).to_not have_content(user2.email)
    expect(index_page).to have_content(task.description)
    expect(index_page).to_not have_content(task2.description)
  end
end
