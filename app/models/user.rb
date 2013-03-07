class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :username
  
  include Gravtastic

  has_secure_password
  has_many :posts
  has_many :comments
  has_many :followers, :class_name => "Follow", :foreign_key => "followee_id"
  has_many :follows, :class_name => "Follow", :foreign_key => "follower_id"
  has_gravatar

  validates_uniqueness_of :username

  validates_presence_of :username
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :password_confirmation

end
