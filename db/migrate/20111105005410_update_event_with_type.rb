class UpdateEventWithType < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.string :type
    end
  end

  def down
    change_table :tasks do |t|
      t.remove :type
    end
  end
end
