class CreatePoblamientoParams < ActiveRecord::Migration
  def change
    create_table :poblamiento_params do |t|
      t.integer :ot_id
      t.integer :frbr_bcn_type_id
      t.integer :frbr_entity_id
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
