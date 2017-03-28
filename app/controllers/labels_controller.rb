class LabelsController < ApplicationController
  before_action :set_label, only: [:show]

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to label_path(@label), notice: "Label successfully created!"
    else
      render :new, alert: "Something went wrong."
    end
  end

  def show
    @tasks = @label.tasks.where(client_id: current_user.assistant? ? current_user.clients.pluck(:id) : current_user.id)
  end

  private

    def set_label
      @label = Label.find(params[:id])
    end

    def label_params
      params.require(:label).permit(:name, :task_ids => [])
    end

end
