class SearchController < ApplicationController
  def show
    @search = params[:search]

    @question_results = Question.where(title: @search)
    @user_results = User.where(name: @search)
    @post_results = Post.where(title: @search)
    @field_results = Field.where(name: @search)
    @topic_results = Topic.where(name: @search)

  end
end
