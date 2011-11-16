class ModifyOt < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.integer :parent_ot_id
    end
  end

  def down
    change_table :ots do |t|
      t.remove :parent_ot_id
    end
  end
end
