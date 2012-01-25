class AddTeacherAndTeacherIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :teacher, :boolean
    add_column :users, :teacher_id, :integer
  end
end
