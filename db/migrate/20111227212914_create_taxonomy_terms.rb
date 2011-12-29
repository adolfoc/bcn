class CreateTaxonomyTerms < ActiveRecord::Migration
  def change
    create_table :taxonomy_terms do |t|
      t.integer :taxonomy_category_id
      t.string :name

      t.timestamps
    end
  end
end
