class UsersController < ApplicationController

  def show
    @twitter_service = TwitterService.new(current_user)
    @user = params[:screen_name]
    if !@twitter_service.user(@user) || @twitter_service.user(@user).protected?
      redirect_to user_path(current_user.screen_name)
      flash[:info] = "Hey, either that person doesn't exist, or they have a private account."
    end
  end

  def search
    redirect_to user_path(params[:screen_name])
  end
end
