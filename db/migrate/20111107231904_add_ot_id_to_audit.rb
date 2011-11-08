class AddOtIdToAudit < ActiveRecord::Migration
  def up
    change_table :audits do |t|
      t.integer :ot_id
    end
  end

  def down
    change_table :audits do |t|
      t.remove :ot_id
    end
  end
end
