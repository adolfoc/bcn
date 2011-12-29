class CreateTpGeneratedParams < ActiveRecord::Migration
  def change
    create_table :tp_generated_params do |t|
      t.integer :ot_id
      t.integer :legislature
      t.integer :session
      t.date :session_date
      t.string :status
      t.timestamps
    end
  end
end
