class RemoveEdmodoIdFromGroups < ActiveRecord::Migration
  def up
  	remove_column :groups, :edmodo_id
  end

  def down
  	add_column :groups, :edmodo_id, :integer
  end
end
