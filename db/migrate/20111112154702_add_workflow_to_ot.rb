class AddWorkflowToOt < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.string :current_task
      t.string :current_step
    end
  end

  def down
    change_table :ots do |t|
      t.remove :current_task, :current_step
    end
  end
end
