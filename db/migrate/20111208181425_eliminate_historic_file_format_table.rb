class EliminateHistoricFileFormatTable < ActiveRecord::Migration
  def up
    drop_table :historic_file_formats
  end

  def down
    create_table :historic_file_formats do |t|
      t.string :format
      t.integer :ordinal
      t.timestamps
    end
  end
end
