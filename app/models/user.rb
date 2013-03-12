class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :username
  
  include Gravtastic

  has_secure_password
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :followers, :class_name => "Follow", :foreign_key => "followee_id"
  has_many :follows, :class_name => "Follow", :foreign_key => "follower_id"
  has_gravatar

  validates_uniqueness_of :username

  validates_presence_of :username
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create

  # used to generate unique random validation tokens for users
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def send_account_activation
    generate_token(:user_confirmation_token)
    save!
    UserMailer.activate_account(self).deliver
  end
end
