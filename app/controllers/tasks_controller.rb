class TasksController < ApplicationController
  expose :tasks, -> { TaskDecorator.decorate_collection(user_tasks) }
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
        next if task.completed?
        task.update!(completed: true, finished_at: DateTime.now)
      end
      flash[:notice] = 'Updated tasks!'
    end
    redirect_to tasks_path
  end

  def remove_selected
    removed = selected_tasks.each(&:delete)
    flash[:notice] = "Deleted tasks: #{removed.count}"
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :completed, :deadline).merge(user: current_user)
  end

  def user_tasks
    current_user.tasks.order(created_at: :desc).page params[:page]
  end

  def selected_tasks
    params[:task_ids].map!(&:to_i)
    tasks.object.find(params[:task_ids])
  end
end
