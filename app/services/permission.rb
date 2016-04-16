class Permission

  def initialize(user, controller, action)
    @_user = user
    @_controller = controller
    @_action = action
  end

  def allow?
    if user
      user_permissions
    else
      home_page_permission
    end
  end

  private
    def user
      @_user
    end

    def controller
      @_controller
    end

    def action
      @_action
    end

    def user_permissions
      return true if controller == 'sessions' && action.in?(%w(destroy))
      return true if controller == 'users' && action.in?(%w(show))
      return true if controller == 'static_pages' && action.in?(%w(home))
    end

    def home_page_permission
      return true if controller == 'sessions' && action.in?(%w(create))
      return true if controller == 'static_pages' && action.in?(%w(home))
    end
end
