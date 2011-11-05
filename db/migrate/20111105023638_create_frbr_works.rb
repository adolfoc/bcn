class CreateFrbrWorks < ActiveRecord::Migration
  def change
    create_table :frbr_works do |t|
      t.integer :frbr_bcn_type_id
      t.integer :frbr_entity_id
      t.integer :session
      t.date :publication_date

      t.timestamps
    end
  end
end
