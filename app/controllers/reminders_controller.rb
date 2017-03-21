class RemindersController < ApplicationController
  before_action :set_reminder, only: [:dismiss]

  def dismiss
    @reminder.dismiss
    redirect_to request.referer
  end

  private

    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

end
