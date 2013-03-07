class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :body
      t.integer :post_type


      t.timestamps
    end
    add_attachment :posts, :file
  end
end
