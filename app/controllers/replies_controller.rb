class RepliesController < ApplicationController
  def create


    @reply = Reply.new(reply_params)
    @post = Post.find(@reply.post_id)
    @topic = Topic.find(@post.topic_id)

    if !BannedUser.find_by(user: current_user, topic: @topic)
      if !ClosedPost.find_by(post_id: @post.id)
        @reply.date = Time.now
        @reply.user = current_user
        @reply.user_id = current_user.id
        @reply.save
        Notification.create!(user_id:@post.user_id, desc:"new_reply", model_id:@reply.id)
        respond_to  do |format|
          if request.xhr?
            format.js {  }
          else
            format.html { redirect_to topic_post_path(topic_id: Topic.find(@post.topic_id).url, id: @post.url)  }
          end
        end
      else
        flash[:message]= "Post has been closed."
        redirect_to topic_post_path(topic_id: Topic.find(@post.topic_id).url, id: @post.url)
      end
    else
      flash[:danger] = "You have been banned from posting and replying on the topic #{@topic.name}"
      redirect_to topic_path(@topic.name)
    end

  end

  def destroy

  end

private
  def reply_params
    params.require(:reply).permit(:content, :post_id)
  end
end
