class LabelsController < ApplicationController
  before_action :set_label, only: [:show]

  def show

  end

  private

    def set_label
      @label = Label.find(params[:id])
    end
end
