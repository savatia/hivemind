class Question < ActiveRecord::Base
  default_scope	->	{	order(created_at:	:desc)	}
  has_many :answers, :dependent => :delete_all
  has_many :question_votes , :dependent => :delete_all
end
