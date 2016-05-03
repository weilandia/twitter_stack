class UsersController < ApplicationController
  before_filter :check_previous
  before_filter :store_history

  def show
    @twitter_service = TwitterService.new(current_user, params[:max_id])
    @user = params[:screen_name]
    if !@twitter_service.user(@user) || @twitter_service.user(@user).protected?
      redirect_to user_path(current_user.screen_name)
      flash[:info] = "Hey, either that person doesn't exist, or they have a private account."
    else
      @tweets = @twitter_service.user_timeline(@user)
      redirect_to user_path(@user) if @tweets.empty?
    end
  end

  def search
    session[:history].clear
    redirect_to user_path(params[:screen_name])
  end

  private
  def check_previous
    if params[:prev]
      session[:history].pop if session[:history].length > 1
      redirect_to session[:history].last
    end
  end

  def store_history
    session[:history] ||= []
    session[:history] << request.url
    session[:history].uniq!
  end
end
