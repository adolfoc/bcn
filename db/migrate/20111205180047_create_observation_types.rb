class CreateObservationTypes < ActiveRecord::Migration
  def change
    create_table :observation_types do |t|
      t.string :name
      t.integer :ordinal

      t.timestamps
    end
  end
end
