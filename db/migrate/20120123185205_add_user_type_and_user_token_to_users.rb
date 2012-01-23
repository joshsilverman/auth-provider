class AddUserTypeAndUserTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :string
    add_column :users, :user_token, :string
  end
end
