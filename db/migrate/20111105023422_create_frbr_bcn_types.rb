class CreateFrbrBcnTypes < ActiveRecord::Migration
  def change
    create_table :frbr_bcn_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
