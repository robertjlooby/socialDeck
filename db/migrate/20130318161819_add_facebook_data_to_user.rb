class AddFacebookDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_username, :string
    add_column :users, :facebook_id, :integer
    add_column :users, :facebook_oauth_token, :string
  end
end
