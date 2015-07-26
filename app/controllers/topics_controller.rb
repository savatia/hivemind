class TopicsController < ApplicationController
  before_action :logged_in, except: :show
  def new
    if current_user.admin?
      @topic = Topic.new
    else
      flash[:danger] = "Not authorized"
      redirect_to root_url
    end
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.url = check_duplicate_url @topic.name.split(" ").join("_")[0..30], Topic
    @topic.save
    flash.now[:success] = "Topic created"
    redirect_to forums_path
  end

  def show
    @topic = Topic.find_by(url: params[:id])
    @posts = Post.where(topic_id: @topic.id)
  end

  def destroy
  end

  def index
    @topics =Topic.all
  end

  private
  def topic_params
    params.require(:topic).permit(:general, :name)
  end
end
