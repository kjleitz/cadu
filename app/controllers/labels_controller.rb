class LabelsController < ApplicationController
  before_action :set_label, only: [:show]

  def show
    @tasks = Task.where(label_id: @label.id)
  end

  private

    def set_label
      @label = Label.find(params[:id])
    end
end
