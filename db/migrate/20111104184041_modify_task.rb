class ModifyTask < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.integer :ot_id
    end
  end

  def down
    change_table :tasks do |t|
      t.remove :ot_id
    end
  end
end
