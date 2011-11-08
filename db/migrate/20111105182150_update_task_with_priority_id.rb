class UpdateTaskWithPriorityId < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.remove :priority
      t.integer :priority_id
    end
  end

  def down
    change_table :tasks do |t|
      t.remove :priority_id
      t.integer :priority
    end
  end
end
