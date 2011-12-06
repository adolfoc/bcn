class CreateTaskTransitions < ActiveRecord::Migration
  def change
    create_table :task_transitions do |t|
      t.string :workflow
      t.string :from_state
      t.string :to_state
      t.integer :minutes
      t.timestamps
    end
  end
end
