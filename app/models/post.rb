class Post < ActiveRecord::Base
  # post_types : 0=>text only, 1=>picture, 2=>Video
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

  def file_if_needed
    unless post_type == 0
      validates_presence_of :file
    end
  end

  after_save :handle_tagging

  def handle_tagging
  	words = self.body.split
    words.each do |word|
      if word.start_with?('#')
        word.gsub!('#', '').downcase!
        unless word.length<1 or Tag.exists?(:tagname => word)
        	Tag.create(:tagname => word)
        end
      end
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
