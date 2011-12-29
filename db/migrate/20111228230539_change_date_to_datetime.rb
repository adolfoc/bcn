class ChangeDateToDatetime < ActiveRecord::Migration
  def up
    change_table :tp_generated_params do |t|
      t.remove :session_date
      t.datetime :session_date
    end
  end

  def down
    change_table :tp_generated_params do |t|
      t.remove :session_date
      t.date :session_date
    end
  end
end
