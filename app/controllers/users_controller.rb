class UsersController < ApplicationController
  # skip_before_action :require_login, only: [:index, :new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to user_path(:id)
    else
      render :new
    end
  end

  def show
    require_login
    unless current_user == nil
      @user = current_user

      # Pulls an array of a users active subscriptions
      @user_subscriptions = @user.subscriptions

      # Pulls an array of a users current events they are attending
      @user_events = @user.attended_events
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destory
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :cell, :password, :password_confirmation)
  end

  def require_login
    unless current_user
      redirect_to login_url
    end
  end
end
