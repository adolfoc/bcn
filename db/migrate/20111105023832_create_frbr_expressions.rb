class CreateFrbrExpressions < ActiveRecord::Migration
  def change
    create_table :frbr_expressions do |t|
      t.integer :frbr_work_id
      t.integer :frbr_document_type_id

      t.timestamps
    end
  end
end
