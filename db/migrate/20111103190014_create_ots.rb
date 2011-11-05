class CreateOts < ActiveRecord::Migration
  def change
    create_table :ots do |t|
      t.string :name
      t.integer :priority
      t.integer :created_by
      t.datetime :created_on
      t.datetime :completed_on
      t.timestamps
    end
  end
end
