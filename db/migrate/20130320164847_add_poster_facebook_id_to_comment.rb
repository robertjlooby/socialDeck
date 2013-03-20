class AddPosterFacebookIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :poster_facebook_id, :integer
  end
end
