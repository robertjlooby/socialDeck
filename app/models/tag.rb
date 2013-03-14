class Tag < ActiveRecord::Base
  attr_accessible :tagname

  validates_presence_of :tagname
  validates_uniqueness_of :tagname

  has_many :posttags
  has_many :posts, :through => :posttags

  def as_json(options={})
    {
    	tagname: self.tagname
    }
  end

end
