class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save()
    redirect_to root_url
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(name:params[:id])
  end

  def questions
    @user = User.find_by(name:params[:user_id])
    @questions = Question.where(:user_id => @user.id)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
