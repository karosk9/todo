class TasksController < ApplicationController
  before_action :provide_task, only: [:edit, :update, :destroy, :done, :undone]

  def index
    @tasks = current_user.tasks
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
    @task.save!
    redirect_to root_path
  end

  def undone
    @task.completed = false
    @task.save!
    redirect_to root_path
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :completed, :deadline).merge(user: current_user)
  end

  def provide_task
    @task = Task.find(params[:id])
  end

end
