class CreateTpParameters < ActiveRecord::Migration
  def change
    create_table :tp_parameters do |t|
      t.boolean :restrict_chamber_enabled
      t.integer :organism_id
      t.integer :legislature_id
      t.integer :session_id
      t.boolean :restrict_date_enabled
      t.date :from_date
      t.date :to_date
      t.boolean :restrict_person_enabled
      t.string :party_id
      t.string :person_id
      t.string :participation_type_id
      t.string :quality_type_id
      t.boolean :free_search_enabled
      t.string :free_search_text
      t.boolean :taxonomy_search_enabled
      t.string :taxonomy_category_id
      t.string :taxonomy_term_id
      t.boolean :restrict_ds_enabled
      t.string :ds_part_id
      t.integer :ds_page
      t.integer :ds_tome
      t.boolean :restrict_law_enabled
      t.string :bill
      t.string :law

      t.timestamps
    end
  end
end
