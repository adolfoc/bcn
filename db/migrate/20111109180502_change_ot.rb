class ChangeOt < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.string :serial_number
      t.integer :ot_state_id
      t.datetime :target_date
    end
  end

  def down
    change_table :ots do |t|
      t.remove :serial_number, :ot_state_id, :target_date
    end
  end
end
