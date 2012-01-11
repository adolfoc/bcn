class CreateDebateTypes < ActiveRecord::Migration
  def change
    create_table :debate_types do |t|
      t.integer :ordinal
      t.string :name

      t.timestamps
    end
  end
end
