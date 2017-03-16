class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user.try(:authenticate, params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path, alert: "Signed in as #{user.email}."
    else
      redirect_to login_path, alert: "Incorrect email/password combination."
    end
  end

end
