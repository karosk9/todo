require 'rails_helper'

describe 'Edit Task', js: true do
  let(:index_page) { IndexPage.new }
  let(:user) { create(:user) }
  let(:title) { 'Buy some carrots' }
  let(:new_title) { 'Buy carrots and onions'}

  before do
    login_as(user)
    index_page.load
  end

  it 'user removes task from the list' do
    index_page.create(title)
    index_page.edit(new_title)

    expect(current_path).to eq(index_page.url)
    expect(index_page).to_not have_content(title)
    expect(index_page).to have_content(new_title)
  end
end
