class Posttag < ActiveRecord::Base
  attr_accessible :post_id, :tag_id

  belongs_to :tag
  belongs_to :post

  validates_presence_of :post_id
  validates_presence_of :tag_id

  def as_json(options={})
    {
    	post_id: self.post_id,
    	tag_id: self.tag_id
    }
  end
end
