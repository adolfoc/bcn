class CreateFrbrDocumentTypes < ActiveRecord::Migration
  def change
    create_table :frbr_document_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
