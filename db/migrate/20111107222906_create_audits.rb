class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.integer :user_id
      t.integer :role_id
      t.integer :task_id
      t.string :description
      t.timestamps
    end
  end
end
