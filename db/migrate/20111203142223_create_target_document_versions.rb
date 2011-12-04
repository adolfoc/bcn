class CreateTargetDocumentVersions < ActiveRecord::Migration
  def change
    create_table :target_document_versions do |t|
      t.integer :ot_id
      t.integer :user_id
      t.integer :markup_tool_id
      t.string :version
      t.timestamps
    end
  end
end
