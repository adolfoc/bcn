class CreateAmModuleConfigurations < ActiveRecord::Migration
  def change
    create_table :am_module_configurations do |t|
      t.string :ws_endpoint
      t.integer :person_threshold
      t.integer :place_threshold
      t.integer :organization_threshold
      t.timestamps
    end
  end
end
