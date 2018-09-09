require 'rails_helper'
require_relative '../page_objects/login_page'
require_relative '../page_objects/new_task_page'

#WIP

describe 'Testing signing in', js: true do
  app = nil
  let!(:user) { create(:user, email: 'user@example.com', password: 'password') }

  before(:each) do
    app = TasksPage.new(Selenium::WebDriver.for(:chrome))
    login_as(user)
  end

  after(:each) do
    app.quit
  end

  it 'signed in user adds new task' do
    new_task = app
      .navigate_to_new_task_page
      .fill_in_description('buy 2 carrots')
      .submit
    expect(page).to have_current_path('/')
    expect(page).to have_content('buy 2 carrots')
  end
end
