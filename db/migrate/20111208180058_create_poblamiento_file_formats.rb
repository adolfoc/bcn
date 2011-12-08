class CreatePoblamientoFileFormats < ActiveRecord::Migration
  def change
    create_table :poblamiento_file_formats do |t|
      t.string :format
      t.integer :ordinal

      t.timestamps
    end
  end
end
