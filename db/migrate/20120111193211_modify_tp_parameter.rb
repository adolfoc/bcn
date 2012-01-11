class ModifyTpParameter < ActiveRecord::Migration
  def up
    change_table :tp_parameters do |t|
      t.integer :document_type_id
      t.integer :debate_type_id
    end
  end

  def down
    change_table :tp_parameters do |t|
      t.remove :document_type_id, :debate_type_id
    end
  end
end
