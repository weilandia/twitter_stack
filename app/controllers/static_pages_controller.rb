class StaticPagesController < ApplicationController
  def home
    if current_user
      redirect_to user_path(current_user.screen_name)
    end
  end
end
