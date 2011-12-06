class AddObservatioTypeToObservation < ActiveRecord::Migration
  def up
    change_table :observations do |t|
      t.integer :observation_type_id
    end
  end

  def down
    change_table :observations do |t|
      t.remove :observation_type_id
    end
  end
end
