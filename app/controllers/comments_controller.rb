class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_task, only: [:create]

  def index
    task = Task.find(params[:task_id])
    render json: task.comments
  end

  def create
    @comment = @task.comments.build(comment_params)
    authorize @comment
    if @comment.save
      @comment.audience.notify(@comment.task, "#{@comment.author.name} commented on '#{@comment.task.title}'.")
      respond_to do |format|
        format.html { redirect_to task_path(@task), notice: 'Comment was successfully created.' }
        format.json { render json: @comment }
      end
    else
      respond_to do |format|
        format.html do
          flash_errors_for @comment
          render 'tasks/show'
        end
        format.json { render json: { error: "Something went wrong." } }
      end
    end
  end

  def destroy
    authorize @comment
    task = @comment.task
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to task_path(task), notice: 'Comment was successfully destroyed.' }
      format.json { render json: { message: "Comment was successfully destroyed" } }
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_task
      @task = Task.find(params[:task_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :task_id, :author_id)
    end
end
