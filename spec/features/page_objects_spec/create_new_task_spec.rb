require 'rails_helper'

describe 'New Task' do
  let(:new_task_page) { NewTaskPage.new }
  let(:index_page) { IndexPage.new }
  let(:user) { create(:user) }

  before do
    login_as(user)
    index_page.load
  end

  it 'user adds new task to the list' do
    index_page.create('Buy some carrots')

    expect(current_path).to eq(index_page.url)
    expect(index_page.flash_message).to eq('Task was successfully created')
    expect(index_page.tasks.count).to eq(1)
  end
end
