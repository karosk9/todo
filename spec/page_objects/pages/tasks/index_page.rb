require 'rails_helper'

class IndexPage < SitePrism::Page
  set_url '/'

  elements :tasks, 'tbody#tasks td.title'
  element :success_message, 'div#flash_success'
  element :new_task_button, 'a#new_task'
  element :edit_task_button, "a.edit_task"
  element :delete_task_button, "a.delete_task"
  element :done_task_button, "a.done"
  element :restore_task_button, "a.restore"

  expected_elements :new_task_button,
                    :edit_task_button,
                    :delete_task_button


  def create(title)
    new_task_button.click
    fill_in 'Title', with: title
    click_button 'Create Task'
  end

  def delete
    delete_task_button.click
  end

  def edit(other_title)
    edit_task_button.click
    fill_in 'Title', with: other_title
    click_button 'Update Task'
  end

  def mark_as_done
    done_task_button.click
  end

  def restore
    restore_task_button.click
  end

  def flash_message
    success_message.text
  end

  def count
  end
end
