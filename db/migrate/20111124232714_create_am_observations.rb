class CreateAmObservations < ActiveRecord::Migration
  def change
    create_table :am_observations do |t|
      t.integer :am_results_id
      t.integer :am_run_observation_type_id
      t.integer :line
      t.string :contents
      t.timestamps
    end
  end
end
