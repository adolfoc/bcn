class UpdateTaskWithOffsets < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.string :xpath_section
    end
  end

  def down
    change_table :tasks do |t|
      t.remove :xpath_section
    end
  end
end
