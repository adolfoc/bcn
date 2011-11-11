class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.integer :ot_id
      t.integer :user_id
      t.text :contents
      t.timestamps
    end
  end
end
