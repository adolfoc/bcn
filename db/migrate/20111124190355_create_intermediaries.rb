class CreateIntermediaries < ActiveRecord::Migration
  def change
    create_table :intermediaries do |t|
      t.string :name
      t.timestamps
    end
  end
end
