class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_task, only: [:create]

  def create
    @comment = @task.comments.build(comment_params)
    authorize @comment
    if @comment.save
      @comment.audience.notify(@comment.task, "#{@comment.author.name} commented on '#{@comment.task.title}'.")
      redirect_to task_path(@task), notice: 'Comment was successfully created.'
    else
      flash_errors_for @comment
      render 'tasks/show'
    end
  end

  def destroy
    authorize @comment
    task = @comment.task
    @comment.destroy
    redirect_to task_path(task), notice: 'Comment was successfully destroyed.'
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
