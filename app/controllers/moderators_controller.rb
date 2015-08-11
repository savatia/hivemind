class ModeratorsController < ApplicationController
  before_action :authaurized?
  def new
    @moderator = Moderator.new
    @users = User.all
  end

  def create
    @moderator = Moderator.new
    @moderator.user = User.find_by(name: moderator_params[:user])
    @moderator.field = Field.find_by(name: moderator_params[:field])
    if Moderator.find_by(user_id: current_user.id, field_id: @moderator.field_id) or current_user.admin?
      if(Moderator.find_by(field: @moderator.field, user:@moderator.user))
        flash[:message] = "#{User.find(@moderator.user_id).name} is already a moderator of #{Field.find(@moderator.field_id).name}"
        redirect_to new_moderator_path

      elsif !User.find_by(name: moderator_params[:user]) and !moderator_params[:user].nil?
        flash[:message] = "#{moderator_params[:user]} could not be found!"
        render 'new'
      else
        if @moderator.save
          flash[:success] = "#{User.find(@moderator.user_id).name} is now a moderator of #{Field.find(@moderator.field_id).name}"
          redirect_to new_moderator_path
        else
          render 'new'
        end
      end
    else
      flash[:danger] = "Not authaurized!"
      redirect_to new_moderator_path
    end

  end

  def index

  end

  private
  def moderator_params
    params.require(:moderator).permit(:user, :field)
  end

  def authaurized?
    if current_user.nil?
      flash[:danger] = "Not authaurized!"
      redirect_to root_path
      false
    else
      if(current_user.admin? or Moderator.find_by(user: current_user))
        true
      else
        flash[:danger] = "Not authaurized!"
        redirect_to root_path
        false
      end
    end

  end

end
