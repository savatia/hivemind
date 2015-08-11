class SearchController < ApplicationController
  def show
    @search = params[:search]

    @question_results = Question.where(name: @search)
    @user_results = User.where(name: @search)
    @post_results = Post.all.include?(@search)

  end
end
