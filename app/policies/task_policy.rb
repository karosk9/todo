class TaskPolicy
  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def actionable?
    user.admin? || user == task.user
  end

  def manageable?
    user.admin? || user == task.user || user.id == task.assignee_id
  end
end
