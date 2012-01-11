class ModifyTpGeneratedParameter < ActiveRecord::Migration
  def up
    change_table :tp_generated_params do |t|
      t.string :action
    end
  end

  def down
    change_table :tp_generated_params do |t|
      t.remove :action
    end
  end
end
