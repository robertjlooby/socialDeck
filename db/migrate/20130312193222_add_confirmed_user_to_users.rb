class AddConfirmedUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed_user, :boolean
    add_column :users, :user_confirmation_token, :string
  end
end
