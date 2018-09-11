module TasksHelper
  def done(task)
    if task.completed
      link_to 'Restore', undone_task_path(task), class: 'btn btn-success restore'
    else
      link_to 'Done!', done_task_path(task), class: 'btn btn-danger done'
    end
  end

  def created(task)
    time_ago_in_words(task.created_at) + ' ago'
  end

  def deadline_time(task)
    return 'done' if task.completed?
    return 'no deadline' if task.deadline.nil?
    return 'today' if task.deadline == Date.today
    'in ' + distance_of_time_in_words(Date.today, task.deadline)
  end

  def total_todo
    current_user.tasks.where(completed: false).count
  end

  def already_done_tasks
    current_user.tasks.where(completed: true).count
  end
end
