class CreateTramiteNormativos < ActiveRecord::Migration
  def change
    create_table :tramite_normativos do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
