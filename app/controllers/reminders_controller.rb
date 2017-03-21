class RemindersController < ApplicationController
  before_action :set_reminder, only: [:dismiss]

  def dismiss
    @reminder.dismiss
  end

  private

    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

end
