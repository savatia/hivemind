class TopicsController < ApplicationController
  def new
    @topic = Topic.new
  end

  def create

  end

  def destroy

  end

  def index
    @topics =Topic.all
  end
end
