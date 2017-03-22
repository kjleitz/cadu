class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :request_assistance, :mark_complete]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
    @task = Task.new(client: current_user)
  end

  def show
    @comments = @task.comments.order(:created_at)
    @new_comment = @task.comments.build
  end

  def new
    @task = Task.new
  end

  def edit
    @comments = @task.comments.order(:created_at)
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

  def mark_complete
    @task.mark_complete
    redirect_to request.referer, notice: "Task marked complete!"
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :due_date, :client_id, label_ids: [])
    end
end
