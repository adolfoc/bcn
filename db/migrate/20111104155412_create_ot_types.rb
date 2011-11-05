class CreateOtTypes < ActiveRecord::Migration
  def change
    create_table :ot_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
