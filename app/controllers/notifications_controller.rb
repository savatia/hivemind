class NotificationsController < ApplicationController
  def index
    @unseen_notifications = Notification.where(user_id:  current_user.id, seen: nil)
    @seen_notifications = Notification.where(user_id:  current_user.id, seen: true)
  end

  def destroy
    Notification.find(params[:id]).destroy
    redirect_to notifications_path
  end
end
