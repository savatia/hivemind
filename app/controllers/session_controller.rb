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
        log_in(@user)
        redirect_to user_path(id: @user.name)
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
