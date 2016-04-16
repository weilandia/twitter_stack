class UsersController < ApplicationController

  def show
    @twitter_service = TwitterService.new(current_user)
    @user = params[:screen_name]
  end
end
