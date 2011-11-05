class UpdateOtWithOtType < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.integer :ot_type_id
    end
  end

  def down
    change_table :ots do |t|
      t.remove :ot_type_id
    end
  end
end
