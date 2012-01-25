class AddGroupsUsersTable < ActiveRecord::Migration
  def change
    create_table :groups_users, :id => false do |t|
      t.references :group, :user
    end
  end
end
