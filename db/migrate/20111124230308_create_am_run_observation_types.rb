class CreateAmRunObservationTypes < ActiveRecord::Migration
  def change
    create_table :am_run_observation_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
