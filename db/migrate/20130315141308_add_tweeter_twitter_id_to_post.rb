class AddTweeterTwitterIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :tweeter_twitter_id, :integer
  end
end
