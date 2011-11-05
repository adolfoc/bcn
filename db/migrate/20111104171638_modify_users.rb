class ModifyUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.integer :role_id
      t.string :user_name
    end
  end

  def down
    change_table :users do |t|
      t.remove :role_id, :user_name
    end
  end
end
