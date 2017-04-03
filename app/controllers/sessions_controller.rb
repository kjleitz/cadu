class SessionsController < ApplicationController

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    if auth
      user = User.from_omniauth(auth)
      if user.save
        session[:user_id] = user.id
        redirect_to tasks_path, notice: "Signed in with #{user.provider_name} as #{user.name}."
      else
        flash_errors_for user
        redirect_to login_path
      end
    else
      user = User.find_by(email: params[:user][:email])
      if user.try(:authenticate, params[:user][:password])
        session[:user_id] = user.id
        redirect_to tasks_path, notice: "Signed in as #{user.email}."
      else
        flash[:error] = "Incorrect email/password combination."
        redirect_to login_path
      end
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, alert: "Successfully logged out!"
  end

  def auth
    request.env['omniauth.auth']
  end

end
