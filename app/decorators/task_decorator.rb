class TaskDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all
  decorates_association :user
  decorates_association :assignee

  def check_if_done
    if policy(task).manageable?
      if completed?
        link_to 'Restore', undone_task_path(object), class: 'btn btn-success restore'
      else
        link_to 'Done!', done_task_path(object), class: 'btn btn-danger done'
      end
    end
  end

  def created
    time_ago_in_words(object.created_at) + ' ago'
  end

  def deadline_time
    return 'done' if completed?
    return 'no deadline' if deadline.nil?
    return 'today' if deadline == Date.today
    'in ' + distance_of_time_in_words(Date.today, deadline)
  end

  def finish_time
    completed? ? (time_ago_in_words(object.updated_at) + ' ago') : 'in progress'
  end

  def decorated_title
    title.blank? ? 'No title' : title
  end

  def actions
    render 'actions', model: task if policy(task).actionable?
  end
end
