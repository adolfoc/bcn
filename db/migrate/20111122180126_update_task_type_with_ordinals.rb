class UpdateTaskTypeWithOrdinals < ActiveRecord::Migration
  def up
    change_table :task_types do |t|
      t.integer :ordinal
    end
  end

  def down
    change_table :task_types do |t|
      t.remove :ordinal
    end
  end
end
