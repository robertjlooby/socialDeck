class AddGithubDataToPost < ActiveRecord::Migration
  def change
    add_column :posts, :github_post_id, :bigint
    add_column :posts, :poster_github_id, :integer
  end
end
