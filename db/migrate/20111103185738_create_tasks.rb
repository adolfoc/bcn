class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :priority
      t.integer :created_by
      t.datetime :created_on
      t.datetime :completed_on
      t.integer :current_user_id
      t.timestamps
    end
  end
end
