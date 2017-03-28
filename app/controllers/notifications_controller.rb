class NotificationsController < ApplicationController

  def view
    @user = User.find(params[:user_id])
    @notification = @user.notifications.find(:id)
    @notification.view
    redirect_to task_path(@notification.task)
  end

end
