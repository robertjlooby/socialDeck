class AddTweetIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :tweet_id, :integer
  end
end
