class CreateTaxonomyCategories < ActiveRecord::Migration
  def change
    create_table :taxonomy_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
