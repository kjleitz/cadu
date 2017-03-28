class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_task, only: [:create]

  def create
    @comment = @task.comments.build(comment_params)
    if @comment.save
      flash[:message] = 'Comment was successfully created.'
      @comment.audience.notify(@comment.task, "#{@comment.author.name} commented on '#{@comment.task.title}'.")
    else
      flash[:error] = @comment.errors.full_messages.join(". ") + "."
    end
    redirect_to task_path(@task)
  end

  def destroy
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
