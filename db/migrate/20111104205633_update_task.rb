class UpdateTask < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.integer :task_type_id
      t.remove :name
    end
  end

  def down
    change_table :tasks do |t|
      t.remove :task_type_id
      t.string :name
    end
  end
end
