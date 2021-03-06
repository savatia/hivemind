module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout
    session[:user_id] = nil
  end

  def current_user?(user)
     @current_user == user
  end

  def current_user
    if session[:user_id]
      if @current_user
        @current_user
      else
        @current_user = User.find_by(id: session[:user_id])
      end
    end
  end

  def is_admin?
    @current_user.admin?
  end

  def logged_in
    if current_user.nil?
      flash[:message] = "Login to continue!"
      redirect_to login_path
    end
  end

  def moderator
    if !Moderator.find_by(user: current_user)
      flash[:message] = "Not Authorized!"
      redirect_to root_url
    end
  end

end
