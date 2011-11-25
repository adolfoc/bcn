class CreateAmResults < ActiveRecord::Migration
  def change
    create_table :am_results do |t|
      t.datetime :run_date
      t.integer :ot_id
      t.timestamps
    end
  end
end
