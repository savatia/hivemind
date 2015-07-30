class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)
    @post = Post.find(@reply.post_id)
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
  end

  def destroy

  end

private
  def reply_params
    params.require(:reply).permit(:content, :post_id)
  end
end
