class TasksController < ApplicationController
  before_action :authorize_task_actions, only: [:update, :edit, :destroy]
  before_action :authorize_task_management, only: [:done, :undone, :finish_selected]

  expose :task

  def create
    if task.save
      redirect_to root_path, notice: 'Task was successfully created'
    else
      render :new
    end
  end

  def update
    if task.update(task_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    task.destroy
    redirect_to root_path, notice: 'Task was successfully deleted'
  end

  def done
    task.update!(completed: true, finished_at: task.updated_at)
    redirect_to root_path
  end

  def undone
    task.update!(completed: false)
    redirect_to root_path
  end

  def update_selected
    return redirect_to tasks_path unless params[:task_ids].present?
    return finish_selected if params[:finish]
    return remove_selected if params[:remove]
  end

  def finish_selected
    Task.transaction do
      selected_tasks.each do |task|
        authorize task, :manageable?
        next if task.completed?
        task.update!(completed: true, finished_at: DateTime.now)
      end
      flash[:notice] = 'Updated tasks!'
    end
    redirect_to tasks_path
  end

  def remove_selected
    Task.transaction do
      removed = selected_tasks.each do |task|
        authorize task, :actionable?
        task.destroy
      end
      flash[:notice] = "Deleted tasks: #{removed.count}"
    end
    redirect_to tasks_path
  end

  private

  def authorize_task_actions
    authorize task, :actionable?
  end

  def authorize_task_management
    authorize task, :manageable?
  end

  def user_tasks
    current_user.tasks.order(created_at: :desc).page params[:page]
  def task_params
    params.require(:task).permit(:title, :content, :completed, :deadline, :assignee_id).merge(user: current_user)
  end

  def selected_tasks
    params[:task_ids].map!(&:to_i)
    tasks.object.find(params[:task_ids])
  end
end
