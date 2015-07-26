class Closing < ActiveRecord::Base
  belongs_to :moderator
  belongs_to :question
end
