class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :request_assistance, :accept, :start, :mark_complete]
  before_action :authorize_task, only: [:show, :edit, :update, :destroy, :request_assistance, :accept, :start, :mark_complete]

  def index
    authorize Task
    if params[:user_id]
      @user = User.find(params[:user_id])
      authorize @user, :show?
      @tasks = policy_scope(@user.tasks)
    else
      @tasks = policy_scope(Task)
    end
    @task = current_user.tasks.build
  end

  def show
    respond_to do |format|
      format.html { @comment = @task.comments.build; render :show }
      format.json { render json: @task }
    end
  end

  def edit
    @comments = @task.comments
  end

  def create
    @task = Task.new(task_params)
    authorize @task
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      @tasks = policy_scope(Task)
      flash_errors_for @task
      render :index
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      flash_errors_for @task
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully deleted.'
  end

  # Maybe the following actions should ultimately be part of #update. But, I
  # think that since notifications should be triggered with the associated
  # method calls on @task, and actions should be kept slim, I would prefer to
  # have these status changes solidified into their own actions, rather than
  # have a big conditional in #update. A redesign might allow notifications to
  # be sent based on status change alone, allowing a slim #update and removal
  # of these paths, but for now I'm going to let it be.

  def request_assistance
    @task.request_assistance
    redirect_to tasks_path, notice: "Assistance with '#{@task.title}' requested!"
  end

  def accept
    @task.accept
    redirect_to tasks_path, notice: "Assistance request for '#{@task.title}' accepted!"
  end

  def start
    @task.start
    redirect_to tasks_path, notice: "'#{@task.title}' is in progress!"
  end

  def mark_complete
    @task.mark_complete
    redirect_to request.referrer, notice: "'#{@task.title}' has been completed!"
  end

  private

    def set_task
      @task = Task.find(params[:task_id] || params[:id])
    end

    def authorize_task
      authorize @task
    end

    def task_params
      params.require(:task).permit(:title, :content, :due_date, :client_id, label_ids: [], labels_attributes: [:name])
    end
end
