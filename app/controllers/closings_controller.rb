class ClosingsController < ApplicationController
  before_action :moderator
  def new
    @closing = Closing.new
  end

  def create
    @closing = Closing.new(closing_params)
    @closing.moderator = Moderator.find_by(:user_id => current_user.id)
    @closing.save
  end

  def closing_params
    params.require(:closing).permit(:question_id, :reason)
  end
end
