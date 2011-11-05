class CreateFrbrManifestations < ActiveRecord::Migration
  def change
    create_table :frbr_manifestations do |t|
      t.integer :frbr_expression_id
      t.string :document_file_name
      t.string :document_content_type
      t.integer :document_file_size
      t.datetime :document_updated_at
      t.timestamps
    end
  end
end
