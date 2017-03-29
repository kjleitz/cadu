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

    def user_not_authorized
      if logged_in?
        flash[:alert] = "You are not authorized to perform this action."
      else
        flash[:alert] = "You must be logged in to access Cadu."
      end
      redirect_to(request.referrer || root_path)
    end
end
