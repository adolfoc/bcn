class AddReadBitToOt < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.boolean :read, :default => false
    end
  end

  def down
    change_table :ots do |t|
      t.remove :read
    end
  end
end
