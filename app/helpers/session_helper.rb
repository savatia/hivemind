module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
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


end
