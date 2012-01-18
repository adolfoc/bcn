class CreateBitacoras < ActiveRecord::Migration
  def change
    create_table :bitacoras do |t|
      t.integer :bulletin_id
      t.integer :frbr_manifestation_id
      t.integer :tramite_constitucional_id
      t.integer :tramite_normativo_id
      t.text :comments
      t.integer :user_id

      t.timestamps
    end
  end
end
