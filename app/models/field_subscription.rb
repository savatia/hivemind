class FieldSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :field
end
