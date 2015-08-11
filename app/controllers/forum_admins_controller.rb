class ForumAdminsController < ApplicationController
  def index
  end

  def create
    @admin = ForumAdmin.new
    @admin.user = User.find_by(name: forum_admin_params[:user])
    @admin.topic = Topic.find_by(name: forum_admin_params[:topic])
    if ForumAdmin.find_by(user_id: current_user.id, topic_id: @admin.topic_id) or current_user.admin?
      if(ForumAdmin.find_by(topic: @admin.topic, user:@admin.user))
        flash[:message] = "#{User.find(@admin.user_id).name} is already an administrator of #{Topic.find(@admin.topic_id).name}"
        redirect_to new_forum_admin_path

      elsif !User.find_by(name: forum_admin_params[:user]) and !forum_admin_params[:user].nil?
        flash[:message] = "#{forum_admin_params[:user]} could not be found!"
        render 'new'
      else
        if @admin.save
          flash[:success] = "#{User.find(@admin.user_id).name} is now a administrator of #{Topic.find(@admin.topic_id).name}"
          redirect_to new_forum_admin_path
        else
          render 'new'
        end
      end
    else
      flash[:danger] = "Not authaurized!"
      redirect_to new_forum_admin_path
    end
  end

  def new
    @forum_admin = ForumAdmin.new
  end

  def destroy
  end

  private

  def forum_admin_params
    params.require(:forum_admin).permit(:user, :topic)
  end
end
