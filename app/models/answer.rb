class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :answer_votes, dependent: :delete_all

  before_destroy


  def destroy_notification
    Notification.where(model_id:id, desc:"best_answer").destroy_all
    Notification.where(model_id:id, desc:"new_answer").destroy_all
  end
end
