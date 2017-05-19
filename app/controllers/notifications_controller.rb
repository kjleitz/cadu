class NotificationsController < ApplicationController

  def view
    @user = User.find(params[:user_id])
    @notification = @user.notifications.find(params[:id])
    authorize @notification
    @notification.view
    respond_to do |format|
      format.html { redirect_to task_path(@notification.task) }
      format.json { render json: @notification }
    end
  end

end
