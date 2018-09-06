module TasksHelper
  def done(task)
    if task.completed
      link_to 'Restore', undone_task_path(task), class: 'btn btn-success'
    else
      link_to 'Done!', done_task_path(task), class: 'btn btn-danger'
    end
  end
end
