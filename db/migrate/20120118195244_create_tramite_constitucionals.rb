class CreateTramiteConstitucionals < ActiveRecord::Migration
  def change
    create_table :tramite_constitucionals do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
