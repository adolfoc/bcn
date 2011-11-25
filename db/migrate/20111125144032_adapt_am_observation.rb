class AdaptAmObservation < ActiveRecord::Migration
  def up
    change_table :am_observations do |t|
      t.remove :am_results_id
      t.integer :am_result_id
    end
  end

  def down
    change_table :am_observations do |t|
      t.remove :am_result_id
      t.integer :am_results_id
    end
  end
end
