class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :request_assistance]

  def index
    @tasks = Task.all
    @task = Task.new(client: current_user)
    @notifications = current_user.notifications
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def request_assistance
    @task.request_assistance
    flash[:message] = "Assistance with '#{@task.title}' requested!"
    redirect_to tasks_path
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :due_date, :client_id, label_ids: [])
    end
end
