class BannedUsersController < ApplicationController
  def index
  end

  def create
    @user = User.find(params[:user_id])
    @topic = Topic.find(params[:topic_id])
    if ForumAdmin.find_by(user_id: current_user.id, topic_id: params[:topic_id]) or current_user.admin?
      if @user.admin? or ForumAdmin.find_by(user: @user, topic_id: params[:topic_id])
        flash[:success] = "User cannot be banned"
        redirect_to topic_path(@topic.url)
      else

        if !BannedUser.find_by(user: @user, topic:@topic).nil?
          BannedUser.find_by(user: @user, topic:@topic).delete
          flash[:success] = "User unbanned"
          redirect_to topic_path(@topic.url)
        else
          BannedUser.create!(user:@user, topic: @topic)
          flash[:success] = "User banned"
          redirect_to topic_path(@topic.url)
        end
      end
    else
      flash[:success] = "Not authaurized!"
      redirect_to topic_path(@topic.url)
    end
  end

  def new

  end

  def destroy

  end
end
