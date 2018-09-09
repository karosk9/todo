require 'rails_helper'
require 'spec_helper'
require_relative '../page_objects/login_page'

describe 'Testing signing in' do
  app = nil
  let!(:user) { create(:user, email: 'user@example.com', password: 'password') }

  before(:each) do
    app = AbstractPage.new(Selenium::WebDriver.for(:chrome))
  end

  after(:each) do
    app.quit
  end

  it 'enteres proper values and signs user in' do
    tasks = app
      .navigate_to_app_root
      .fill_in_email('user@example.com')
      .fill_in_password('qazwsx')
      .log_in
    expect(tasks.display_success_message).to be  == 'Logged in successfully.'
  end
end
