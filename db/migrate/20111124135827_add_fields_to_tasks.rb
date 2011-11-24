class AddFieldsToTasks < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.integer :predecessor_id
      t.integer :successor_id
    end
  end

  def down
    change_table :tasks do |t|
      t.remove :predecessor_id, :successor_id
    end
  end
end
