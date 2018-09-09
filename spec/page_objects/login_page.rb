require_relative '../page_objects/abstract_page'
require_relative '../page_objects/tasks_page'

class LoginPage < AbstractPage

  def initialize(driver)
    super(driver)
  end

  def fill_in_email(email)
    @@driver.find_element(id: 'user_email').send_keys email
    return LoginPage.new(@@driver)
  end

  def fill_in_password(password)
    @@driver.find_element(id: 'user_password').send_keys password
    return LoginPage.new(@@driver)
  end

  def log_in
    @@driver.find_element(name: 'commit').click
    return TasksPage.new(@@driver)
  end
end
