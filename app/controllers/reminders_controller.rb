class RemindersController < ApplicationController
  before_action :set_reminder, only: [:dismiss]
  before_action :set_user, only: [:new]

  def new
    @reminder = Reminder.new
  end

  def dismiss
    @reminder.dismiss
    redirect_to request.referer
  end

  private

    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

end
