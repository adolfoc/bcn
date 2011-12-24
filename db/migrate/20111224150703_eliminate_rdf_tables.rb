class EliminateRdfTables < ActiveRecord::Migration
  def up
    drop_table :qualities
    drop_table :participation_types
    drop_table :parties
  end

  def down
    create_table :qualities do |t|
      t.string :name
      t.string :uri
      t.timestamps
    end
    create_table :participation_types do |t|
      t.string :name
      t.string :uri
      t.timestamps
    end
    create_table :parties do |t|
      t.string :name
      t.string :uri
      t.timestamps
    end
  end
end
