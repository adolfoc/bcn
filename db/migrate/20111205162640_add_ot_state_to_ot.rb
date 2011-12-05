class AddOtStateToOt < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.integer :ot_state_id
    end
  end

  def down
    change_table :ots do |t|
      t.remove :ot_state_id
    end
  end
end
