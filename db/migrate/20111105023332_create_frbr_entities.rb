class CreateFrbrEntities < ActiveRecord::Migration
  def change
    create_table :frbr_entities do |t|
      t.string :name

      t.timestamps
    end
  end
end
