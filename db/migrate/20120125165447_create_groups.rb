class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :edmodo_id
      t.string :title

      t.timestamps
    end
  end
end
