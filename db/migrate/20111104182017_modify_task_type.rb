class ModifyTaskType < ActiveRecord::Migration
  def up
    change_table :task_types do |t|
      t.integer :role_id
    end
  end

  def down
    change_table :task_types do |t|
      t.remove :role_id
    end
  end
end
