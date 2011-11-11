class CreateOtStates < ActiveRecord::Migration
  def change
    create_table :ot_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
