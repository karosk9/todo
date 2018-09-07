require 'rails_helper'

class LoginPage < SitePrism::Page
  set_url '/users/login'
  element :email_field, "input[name='user[email]']"
  element :password_field, "input[name='user[password]']"
  element :flash, "div.flash"

  def log_in(email, password)
    email_field.set(email)
    password_field.set(password)
    click_button('Log in')
  end
end


feature 'Login' do
  let(:user) { create(:user) }
  before(:each) do
    @login_page = LoginPage.new
    @login_page.load
  end

  it 'logs in sucessfully' do
    @login_page.load
    expect(@login_page.current_url).to include('example.com/users/login')
    expect(@login_page).to be_displayed
    expect(@login_page).to have_title('Todo')
    expect(@login_page).to have_email_field
    expect(@login_page).to have_password_field
    @login_page.log_in(user.email, user.password)
    expect(@login_page.current_path).to eq('/')
  end
end
