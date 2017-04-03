class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private

    def user_not_authorized(error)
      if !logged_in?
        redirect_to login_path, alert: "You must be logged in to access Cadu."
      elsif current_user.client? && !current_user.assistant
        redirect_to edit_user_path(current_user), alert: "Please select an assistant from the drop-down menu below."
      else
        redirect_to request.referrer || root_path, alert: "You are not authorized to perform this action."
      end
    end
end
