class AddGithubDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_username, :string
    add_column :users, :github_id, :integer
    add_column :users, :github_oauth_token, :string
  end
end
