require 'rails_helper'

describe 'Delete Task', js: true do
  let(:index_page) { IndexPage.new }
  let(:user) { create(:user) }
  let(:title) { 'Buy some carrots' }

  before do
    login_as(user)
    index_page.load
  end

  it 'user removes task from the list' do
    index_page.create(title)
    index_page.delete

    expect(current_path).to eq(index_page.url)
    expect(index_page.flash_message).to eq('Task was successfully deleted')
    expect(index_page).to_not have_content(title)
  end
end
