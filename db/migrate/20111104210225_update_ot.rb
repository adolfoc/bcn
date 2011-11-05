class UpdateOt < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.remove :name, :priority
      t.integer :priority_id
    end
  end

  def down
    change_table :ots do |t|
      t.remove :priority_id
      t.string :name
      t.integer :priority
    end
  end
end
