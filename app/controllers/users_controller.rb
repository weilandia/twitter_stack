class UsersController < ApplicationController

  def show
    @twitter_service = TwitterService.new(current_user)
    @user = params[:screen_name]
    if !@twitter_service.user(@user)
      redirect_to user_path(current_user.screen_name)
      flash[:info] = "Hey, that person doesn't exist."
    end
  end

  def search
    redirect_to user_path(params[:screen_name])
  end
end
