module SessionsHelper
  def log_in(user)
    session[:user_id] = @user.id
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?  
    !current_user.nil?
  end

  def authenticate_user!
    if controller_name != 'users' && action_name != 'new'
      redirect_to '/login' unless logged_in?
    end
  end

  def restrict_auth_page
    if (controller_name == "sessions") && (action_name == "new") || (controller_name == "users") && (action_name == "new")
      redirect_to "/" unless !logged_in?
    end
  end
end
