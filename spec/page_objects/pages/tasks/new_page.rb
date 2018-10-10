class IndexPage < SitePrism::Page
  set_url 'tasks/new'

  element :title, 'input#task_title'
  element :create_task_button, 'input#create_task'
end
