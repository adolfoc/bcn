class CreateQualities < ActiveRecord::Migration
  def change
    create_table :qualities do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
