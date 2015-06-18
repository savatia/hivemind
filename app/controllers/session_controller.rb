class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:session][:username])
    if !@user.nil?
      if @user.authenticate(params[:session][:password])
        log_in(@user)
        redirect_to user_path(@user)
      else
          flash[:danger] = "Incorrect email/password combination"
          redirect_to login_path
      end
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
