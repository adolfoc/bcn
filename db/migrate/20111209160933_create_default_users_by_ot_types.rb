class CreateDefaultUsersByOtTypes < ActiveRecord::Migration
  def change
    create_table :default_users_by_ot_types do |t|
      t.integer :ot_type_id
      t.integer :role_id
      t.integer :user_id

      t.timestamps
    end
  end
end
