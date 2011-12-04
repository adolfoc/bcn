class CreateMarkupTools < ActiveRecord::Migration
  def change
    create_table :markup_tools do |t|
      t.string :name
      t.timestamps
    end
  end
end
