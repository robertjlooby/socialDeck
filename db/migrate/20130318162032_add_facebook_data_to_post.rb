class AddFacebookDataToPost < ActiveRecord::Migration
  def change
    add_column :posts, :poster_facebook_id, :integer
    add_column :posts, :facebook_post_id, :bigint
  end
end
