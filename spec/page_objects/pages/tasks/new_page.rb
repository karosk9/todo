class IndexPage < SitePrism::Page
  set_url 'tasks/new'

  element :description, 'input#task_description'
  element :create_task_button, 'input#create_task'
end
