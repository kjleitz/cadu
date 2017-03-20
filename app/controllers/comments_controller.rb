class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:index, :new, :create]

  def index
    @comments = @task.comments
  end

  def show
  end

  def new
    @comment = @task.comments.build
  end

  def edit
  end

  def create
    @comment = @task.comments.build(comment_params)
    if @comment.save
      flash[:message] = 'Comment was successfully created.'
    else
      flash[:error] = @comment.errors.full_messages.join(". ") + "."
    end
    redirect_to task_path(@task)
  end

  def update
    if @comment.update(comment_params)
      flash[:message] = 'Comment was successfully updated.'
    else
      flash[:error] = @comment.errors.full_messages.join(". ") + "."
    end
    redirect_to task_path(@comment.task)
  end

  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
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
