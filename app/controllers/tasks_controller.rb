class TasksController < ApplicationController
  before_action :provide_task, only: [:edit, :update, :destroy, :done, :undone]

  def index
    @tasks = current_user.tasks.order(created_at: :desc).page params[:page]
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: 'Task was successfully created'
      set_title_if_not_present
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'Task was successfully deleted'
  end

  def done
    @task.completed = true
    @task.finished_at = @task.updated_at
    @task.save!
    redirect_to root_path
  end

  def undone
    @task.completed = false
    @task.save!
    redirect_to root_path
  end

  def update_selected
    @tasks = Task.find(params[:task_ids])
    finish_selected if params[:finish]
    remove_selected if params[:remove]
    redirect_to tasks_path
  end

  private
  def finish_selected
    @tasks.each do |task|
      next if task.completed?
      task.completed = true
      task.finished_at = DateTime.now
      task.save!
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

  def provide_task
    @task = Task.find(params[:id])
  end

  def set_title_if_not_present
    @task.title = 'Unnamed task' unless @task.title?
    @task.save!
  end

end
