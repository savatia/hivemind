class Moderator < ActiveRecord::Base
  belongs_to :user
  belongs_to :field
  validates :user,  presence: true
  validates :field,  presence: true
end
