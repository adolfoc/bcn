class CreateHistoricFileFormats < ActiveRecord::Migration
  def change
    create_table :historic_file_formats do |t|
      t.string :format
      t.integer :ordinal
      t.timestamps
    end
  end
end
