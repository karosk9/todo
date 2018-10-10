require 'rails_helper'

describe 'finish all' do
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 25, user: user) }

  before(:each) do
    login_as(user)
    visit ('/')
  end

  it 'displays common actions buttons' do
    expect(page).to have_button('Finish selected')
    expect(page).to have_button('Remove selected')
  end
end
