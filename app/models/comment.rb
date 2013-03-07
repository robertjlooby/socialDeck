class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :user
  belongs_to :post

  validates_presence_of :user_id
  validates_presence_of :post_id
  validates_presence_of :body

end
