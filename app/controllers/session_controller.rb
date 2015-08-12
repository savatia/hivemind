class SessionController < ApplicationController
  def new
    if !current_user.nil?
      redirect_to root_url
    end
  end

  def create
    @user = User.find_by(name: params[:session][:username])
    if !@user.nil? && current_user.nil?
      if @user.authenticate(params[:session][:password])
        if @user.activated?
          log_in @user
          #params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          redirect_back_or user
        else
          message  = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:danger] = message
          redirect_to root_url
        end
      else
          flash[:danger] = "Incorrect username/password combination"
          redirect_to login_path
      end
    elsif current_user
      redirect_to root_url
    else
      flash[:danger] = "No user found"
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private
    def user_params
      params.require(:session).permit(:username,:password,:remember_me)
    end
end
