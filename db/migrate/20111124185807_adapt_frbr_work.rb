class AdaptFrbrWork < ActiveRecord::Migration
  def up
    change_table :frbr_works do |t|
      t.integer :delivery_method_id
      t.integer :intermediary_id
    end
  end

  def down
    change_table :frbr_works do |t|
      t.remove :delivery_method_id, :intermediary_id
    end
  end
end
