class PostsController < ApplicationController
  before_action :logged_in, only: [:new, :create]
  def new
    @post = Post.new
    @topic = Topic.find_by(url:params[:topic_id])
  end

  def create
    @post = Post.new(post_params)
    @topic = Topic.find(@post.topic_id)

    if !BannedUser.find_by(user: current_user, topic: @topic)
      @post.date = Time.now
      @post.user = current_user
      @post.url = check_duplicate_url @post.title.split(" ").join("_")[0..30], Post

      @post.save
      flash[:success] = "Post Created!"
      redirect_to topic_post_path(id:@post.url, topic_id: @topic.url)
    else
      flash[:danger]  = "You have been banned from posting on #{@topic.name}!"
      redirect_to topic_path(@topic.url)
    end

  end

  def show
    @post = Post.find_by(url: params[:id])
    @reply = Reply.new
    @replies = Reply.where(post_id: @post.id)

    if !current_user.nil?
      Notification.where(seen:nil, user_id: current_user.id, desc:"new_reply").each do |n|
        post = Post.find(Reply.find(n.model_id).post_id)
        if post == @post
          n.seen = true;
          n.save;
        end
      end

    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :topic_id)
  end

end
