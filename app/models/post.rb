class Post < ActiveRecord::Base
  # post_types : 0=>text only, 1=>picture, 2=>Video, 3=>Twitter, 4=>Facebook
  attr_accessible :body, :post_type, :file
  has_attached_file :file, :styles => {:micro => "10x10>", :thumb => "50x50>"}, :default_url => "missing.png"

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :posttags, :dependent => :destroy
  has_many :tags, :through => :posttags

  validates_presence_of :body
  validates_presence_of :user_id
  validates_presence_of :post_type
  validate :file_if_needed

  validates_uniqueness_of :tweet_id

  def file_if_needed
    if post_type == 1 || post_type == 2
      validates_presence_of :file
    end
  end

  after_save :handle_tagging

  def handle_tagging
  	self.body.scan(/\B#\w+/).each do |word|
      unless Tag.exists?(:tagname => word)
      	Tag.create(:tagname => word)
      end
      Posttag.create(:post_id => self.id, :tag_id => Tag.find_by_tagname(word).id)
    end
  end

  def to_param
    "#{self.id}-#{self.user.username.parameterize}"
  end

  def as_json(options={})
    {
      user_id: self.user_id,
      body: self.body,
      post_type: self.post_type
    }
  end
end
