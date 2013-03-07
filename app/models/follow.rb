class Follow < ActiveRecord::Base
  attr_accessible :followee_id, :follower_id

  belongs_to :followee, :class_name => "User", :foreign_key => "user_id"
  belongs_to :follower, :class_name => "User", :foreign_key => "user_id"

  validate :valid_follow
  validates_presence_of :followee_id
  validates_presence_of :follower_id

  def valid_follow
  	if self.follower_id == self.followee_id
  		errors.add(:followee, "you cannot follow yourself (no matter how interesting you may be)")
  	elsif Follow.exists?(:followee_id => self.followee_id, :follower_id => self.follower_id)
  		errors.add(:followee, "you are already following that person")
  	end
  end
  
end
