class TasksController < ApplicationController
  before_action :provide_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created'
    else
      render :new
    end
  end

  def update
    if @task.save!
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully deleted'
  end

  private
  def task_params
    params.require(:task).permit(:description, :completed)
  end

  def provide_task
    @task = Task.find(params[:id])
  end

end
