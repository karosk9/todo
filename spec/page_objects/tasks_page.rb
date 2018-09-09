class TasksPage < AbstractPage

  def initialize(driver)
    super(driver)
  end

  def display_success_message
    @@driver.find_element(id: 'flash_success').text
  end

  # WIP

  def navigate_to_new_task_page
    @@driver.find_element(link: '/tasks/new').click
    return NewTaskPage.new(@@driver)
  end

  def display_current_user_email
    @@driver.find_element(link: '/users/edit').text
  end
end
