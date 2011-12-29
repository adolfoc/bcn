class AdaptTpParameters < ActiveRecord::Migration
  def up
    change_table :tp_parameters do |t|
      t.integer :ot_id
    end
  end

  def down
    change_table :tp_parameters do |t|
      t.remove :ot_id
    end
  end
end
