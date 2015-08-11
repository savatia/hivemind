class ClosedPostsController < ApplicationController

  before_action :authaurized?, only: [:create, :destroy]
  def index
  end

  def create
    @closedpost = ClosedPost.new(closed_post_params)
    @closedpost.forum_admin = ForumAdmin.find_by(:user_id => current_user.id)
    @post = Post.find(@closedpost.post_id)
    if ClosedPost.find_by(post_id: @post.id)
      flash[:message] = "Post has already been closed."
      redirect_to topic_post_path(id: @post.url, topic_id: Topic.find(@post.topic_id).url)
    elsif(ForumAdmin.find_by(user: current_user.id)).topic_id != @post.topic_id
      flash[:message] = "You are not authaurized to do this action."
      redirect_to topic_post_path(id: @post.url, topic_id: Topic.find(@post.topic_id).url)
    elsif @closedpost.save
      redirect_to topic_post_path(id: @post.url, topic_id: Topic.find(@post.topic_id).url)
    else
      flash[:danger] = "Reason required!"
      redirect_to new_closed_post_path+"?post_id=#{@closedpost.post_id}"

    end
  end

  def new
    @closedpost = ClosedPost.new
    @post = Post.find params[:post_id]
    session[:return_to] ||= request.referer

    if ClosedPost.find_by(post_id: params[:post_id])
      flash[:message] = "Post has already been closed."
      redirect_to topic_post_path(id: @post.url, topic_id: Topic.find(@post.topic_id).url)
    elsif(ForumAdmin.find_by(user: current_user.id)).topic_id != @post_id.topic_id
      flash[:message] = "You are not authaurized to do this action."
      redirect_to  redirect_to topic_post_path(id: @post.url, topic_id: Topic.find(@post.topic_id).url)
    end
  end

  def destroy
  end

  private
  def closed_post_params
    params.require(:closed_post).permit(:post_id, :reason)
  end

  def authaurized?
    if current_user.nil?
      flash[:danger] = "Not authaurized!"
      redirect_to root_path
      false
    else
      if(ForumAdmin.find_by(user: current_user))
        true
      else
        flash[:danger] = "Not authaurized!"
        redirect_to root_path
        false
      end
    end
  end
end
