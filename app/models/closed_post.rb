class ClosedPost < ActiveRecord::Base
  belongs_to :forum_admin
  belongs_to :post
end
