class LabelsController < ApplicationController
  before_action :set_label, only: [:show]

  def index
    @labels = Label.all
  end

  def show
    @tasks = @label.tasks.where(client_id: current_user.assistant? ? current_user.clients.pluck(:id) : current_user.id)
  end

  private

    def set_label
      @label = Label.find(params[:id])
    end
end
