class UpdateOtWithByRequestOf < ActiveRecord::Migration
  def up
    change_table :ots do |t|
      t.string :by_request_of
    end
  end

  def down
    change_table :ots do |t|
      t.remove :by_request_of
    end
  end
end
