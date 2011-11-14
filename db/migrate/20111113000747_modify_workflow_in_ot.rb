class ModifyWorkflowInOt < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.remove :current_task, :ot_state_id
      t.integer :current_task_id
    end
  end

  def down
    change_table :ots do |t|
      t.remove :current_task_id
      t.string :current_task
      t.integer :ot_state_id
    end
  end
end
