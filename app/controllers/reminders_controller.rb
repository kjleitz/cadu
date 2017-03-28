class RemindersController < ApplicationController
  before_action :set_reminder, only: [:dismiss, :destroy]
  before_action :set_user, only: [:new, :create]

  def new
    @reminder = @user.reminders.build(task_id: params[:task_id])
  end

  def create
    @reminder = @user.reminders.build(reminder_params)
    if @reminder.save
      redirect_to tasks_path, notice: "Reminder sent."
    else
      render :new
    end
  end

  def destroy
    @reminder.destroy
    redirect_to root_path, alert: "Reminder successfully removed."
  end

  def dismiss
    @reminder.dismiss
    redirect_to request.referer, notice: "Reminder dismissed."
  end

  private

    def set_reminder
      @reminder = Reminder.find(params[:reminder_id] || params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def reminder_params
      params.require(:reminder).permit(:content, :task_id)
    end

end
