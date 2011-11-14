class RemoveSerialNumberFromOt < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.remove :serial_number
    end
  end

  def down
    change_table :ots do |t|
      t.string :serial_number
    end
  end
end
