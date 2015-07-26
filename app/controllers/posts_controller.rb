class PostsController < ApplicationController
  def new
    @post = Post.new
    @topic = Topic.find_by(url:params[:topic_id])
  end

  def create
    @post = Post.new(post_params)
    @post.date = Time.now
    @post.user = current_user
    @post.url = check_duplicate_url @post.title.split(" ").join("_")[0..30], Post
    @topic = Topic.find(@post.topic_id)
    @post.save
    flash[:success] = "Topic Created!"
    redirect_to topic_post_path(id:@post.url, topic_id: @topic.url)
  end

  def show
    @post = Post.find_by(url: params[:id])
    @reply = Reply.new
    @replies = Reply.where(post_id: @post.id)
  end

  def post_params
    params.require(:post).permit(:title, :topic_id)
  end
end
