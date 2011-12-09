class CreatePoblamientoGeneratedParams < ActiveRecord::Migration
  def change
    create_table :poblamiento_generated_params do |t|
      t.integer :ot_id
      t.integer :legislature
      t.integer :session
      t.date :session_date
      t.string :processing
      t.timestamps
    end
  end
end
