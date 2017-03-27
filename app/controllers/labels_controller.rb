class LabelsController < ApplicationController
  before_action :set_label, only: [:show]

  def show
    @tasks = current_user.send("#{"client_" if current_user.assistant?}tasks").where(label_id: @label.id)
  end

  private

    def set_label
      @label = Label.find(params[:id])
    end
end
