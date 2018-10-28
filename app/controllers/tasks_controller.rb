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
    @tasks = tasks.find(params[:task_ids])
    finish_selected if params[:finish]
    remove_selected if params[:remove]
    redirect_to tasks_path
  end

  private
  def finish_selected
    @tasks.each do |task|
      next if task.completed?
      task.update!(completed: true, finished_at: DateTime.now)
    end
    flash[:notice] = "Updated tasks!"
  end

  def remove_selected
    removed = @tasks.each(&:delete)
    flash[:notice] = "Deleted tasks: #{removed.count}"
  end

  def task_params
    params.require(:task).permit(:title, :content, :completed, :deadline).merge(user: current_user)
  end

  end
end
