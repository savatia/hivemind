class ModeratorsController < ApplicationController
  def new
    @moderator = Moderator.new
    @users = User.all
  end
end
