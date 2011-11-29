class AddAmResultsIdToAmConfiguration < ActiveRecord::Migration
  def up
    change_table :am_configurations do |t|
      t.integer :am_result_id
    end
  end

  def down
    change_table :am_configurations do |t|
      t.remove :am_result_id
    end
  end
end
