class AddOrdinalToOtState < ActiveRecord::Migration
  def up
    change_table :ot_states do |t|
      t.integer :ordinal
    end
  end

  def down
    change_table :ot_states do |t|
      t.remove :ordinal
    end
  end
end
