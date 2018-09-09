require_relative '../page_objects/login_page'

class AbstractPage

  @@driver = nil

  def initialize(driver)
    @@driver = driver
  end

  def navigate_to_app_root
    @@driver.navigate.to('http://localhost:3000/users/login')
    return LoginPage.new(@@driver)
  end

  def quit
    @@driver.quit
  end

  def get_title
    @@driver.title
  end
end
