class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if auth
      user = User.from_omniauth(auth)
    else
      user = User.find_by(email: params[:user][:email])
      unless user.try(:authenticate, params[:user][:password])
        redirect_to login_path, alert: "Incorrect email/password combination."
      end
    end
    session[:user_id] = user.id
    redirect_to root_path, alert: "Signed in as #{user.email}."
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, alert: "Successfully logged out!"
  end

  def auth
    request.env['omniauth.auth']
  end

end
