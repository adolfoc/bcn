class AdjustPoblamientoParam < ActiveRecord::Migration
  def up
    change_table :poblamiento_params do |t|
      t.remove :frbr_bcn_type_id
      t.integer :intermediary_id
      t.string :location
      t.string :file_format
    end
  end

  def down
    change_table :poblamiento_params do |t|
      t.integer :frbr_bcn_type_id
      t.remove :intermediary_id, :location, :file_format
    end
  end
end
