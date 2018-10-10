require 'rails_helper'

describe 'New Task' do
  let(:new_task_page) { NewTaskPage.new }
  let(:index_page) { IndexPage.new }
  let(:user) { create(:user, email: 'user@example.com', first_name: 'John', last_name: 'Smith') }
  let(:user2) { create(:user, email: 'user2@example.com') }
  let!(:task) { create(:task, user: user, title: 'task 1') }
  let!(:task2) { create(:task, user: user2, title: 'task 2') }
  let!(:task3) { create(:task, user: user, title: 'task 3') }

  before do
    login_as(user)
    index_page.load
  end

  it "displays only signed in user's tasks" do
    expect(current_path).to eq(index_page.url)
    expect(index_page.tasks.count).to eq(2)
    expect(index_page).to have_content("#{user.first_name} #{user.last_name}")
    expect(index_page).to_not have_content("#{user2.first_name} #{user2.last_name}")
    expect(index_page).to have_content(task.title)
    expect(index_page).to_not have_content(task2.title)
  end
end
