class CreatePoblamientoImportLocations < ActiveRecord::Migration
  def up
    create_table :poblamiento_import_locations do |t|
      t.string :name
      t.timestamps
    end
    change_table :poblamiento_params do |t|
      t.remove :location
      t.integer :location_id
    end
  end

  def down
    drop_table :poblamiento_import_locations
    change_table :poblamiento_params do |t|
      t.remove :location_id
      t.string :location
    end
  end
end
