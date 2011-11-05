class UpdateOtWithFrbr < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.string :source_frbr_manifestation_id
      t.string :target_frbr_manifestation_id
    end
  end

  def down
    change_table :ots do |t|
      t.remove :source_frbr_manifestation_id, :target_frbr_manifestation_id
    end
  end
end
