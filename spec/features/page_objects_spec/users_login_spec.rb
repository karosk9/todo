require 'spec_helper'
require 'rails_helper'

describe 'Login' do
  let(:user) { create(:user) }
  let(:login_page) { LoginPage.new }
  let(:index_page) { IndexPage.new }

  before do
    login_page.load
  end

  it 'logs in sucessfully' do
    login_page.log_in(user.email, user.password)

    expect(current_path).to eq(index_page.url)
    expect(index_page.flash_message).to eq('Logged in successfully.')
  end
end
