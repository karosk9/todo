require 'rails_helper'

describe 'Task managing', js: true do
  let(:index_page) { IndexPage.new }
  let(:user) { create(:user) }
  let(:title) { 'Buy some carrots' }

  before do
    login_as(user)
    index_page.load
  end

  it 'user marks task as done' do
    index_page.create(title)
    index_page.mark_as_done

    expect(index_page).to have_content('Restore')
    expect(index_page).to_not have_content('Done!')
    expect(current_path).to eq(index_page.url)
  end

  it 'user restores the task' do
    index_page.create(title)
    index_page.mark_as_done
    index_page.wait_until_restore_task_button_visible
    index_page.restore

    expect(index_page).to_not have_content('Restore')
    expect(index_page).to have_content('Done!')
    expect(current_path).to eq(index_page.url)
  end
end
