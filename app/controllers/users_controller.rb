class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy]

  def index
    authorize User
    @users = policy_scope(User)
  end

  def show
  end

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User was successfully created.'
    else
      flash_errors_for @user
      render :new
    end
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user }
      end
    else
      flash_errors_for @user
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def authorize_user
      authorize @user
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :assistant_id)
    end
end
