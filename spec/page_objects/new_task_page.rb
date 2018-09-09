require_relative './tasks_page'

# WIP

class NewTaskPage < AbstractPage
  def initialize(driver)
    super(driver)
  end

  def fill_in_description(description)
    @@driver.find_element(id: 'task_description').send_keys description
    return NewTaskPage.new(@@driver)
  end

  def submit
    @@driver.find_element(value: 'Create Task').click
    return TasksPage.new(@@driver)
  end
end
