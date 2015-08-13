class StaticPagesController < ApplicationController
  def home
    if current_user.nil?
      redirect_to landing_path
    end
  end

  def about
  end

  def help
  end

  def admin_functions
  end

  def landing

  end
end
