class UsersController < ApplicationController
  before_action :logged_in, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save()
      @user.send_activation_email
      flash[:message] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
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

  def edit

  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(id:current_user.name)
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :signature, :about)
    end
end
