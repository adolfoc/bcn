class CreateAmConfigurations < ActiveRecord::Migration
  def change
    create_table :am_configurations do |t|
      t.boolean :structural_markup_enabled
      t.boolean :structural_markup_extension_whole_document
      t.boolean :structural_markup_extension_first_level
      t.boolean :structural_markup_extension_second_level
      t.boolean :structural_markup_extension_third_level
      t.boolean :structural_markup_depth_all
      t.string :structural_markup_depth_mark
      t.boolean :semantic_markup_enabled
      t.boolean :semantic_markup_extension_whole_document
      t.boolean :semantic_markup_extension_persons
      t.boolean :semantic_markup_extension_organizations
      t.boolean :semantic_markup_extension_documents
      t.boolean :semantic_markup_extension_places
      t.boolean :semantic_markup_depth_all
      t.string :semantic_markup_depth_mark
      t.timestamps
    end
  end
end
