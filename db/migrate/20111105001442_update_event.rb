class UpdateEvent < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.string :workflow_state
    end
  end

  def down
    change_table :tasks do |t|
      t.remove :workflow_state
    end
  end
end
