class AdaptPoblamientoParamAgain < ActiveRecord::Migration
  def up
    change_table :poblamiento_params do |t|
      t.remove :file_format
      t.integer :file_format_id
    end
  end

  def down
    change_table :poblamiento_params do |t|
      t.remove :file_format_id
      t.string :file_format
    end
  end
end
