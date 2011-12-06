class AddElementsToPoblamientoParams < ActiveRecord::Migration
  def up
    change_table :poblamiento_params do |t|
      t.integer :priority_id
    end
  end

  def down
    change_table :poblamiento_params do |t|
      t.remove :priority_id
    end
  end
end
