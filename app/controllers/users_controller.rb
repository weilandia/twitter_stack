class UsersController < ApplicationController
  before_action :set_user

  def show
    @twitter_client = TwitterService.new(current_user)
  end

  private
    def set_user
      @user = User.find_by(screen_name: params[:screen_name])
    end
end
