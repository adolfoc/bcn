class AddElementsToFrbrWork < ActiveRecord::Migration
  def up
    change_table :frbr_works do |t|
      t.date :event_date
      t.integer :legislature
    end
  end

  def down
    change_table :frbr_works do |t|
      t.remove :event_date, :legislature
    end
  end
end
