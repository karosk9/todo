require 'rails_helper'

class LoginPage < SitePrism::Page
  set_url '/users/login'

  element :email_field, 'input[id=user_email]'
  element :password_field, 'input[id=user_password]'
  element :login_button, "buton[value='Log in']"
  element :register_button, "link[href='users/sign_up']"

  def log_in(email, password)
    email_field.set(email)
    password_field.set(password)
    click_button('Log in')
  end
end
