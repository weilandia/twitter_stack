class SessionsController < ApplicationController

  def create
    user_info = request.env["omniauth.auth"]
    if user = User.from_omniauth(user_info)
      session[:user_id] = user.id
      session[:user_info] = user_info[:info]
    end
    redirect_to user_path(current_user.screen_name)
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
