class AddTwitterDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_username, :string
    add_column :users, :twitter_id, :string
    add_column :users, :twitter_oauth_token, :string
    add_column :users, :twitter_oauth_token_secret, :string
  end
end
