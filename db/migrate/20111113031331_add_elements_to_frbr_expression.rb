class AddElementsToFrbrExpression < ActiveRecord::Migration
  def up
    change_table :frbr_expressions do |t|
      t.integer :version
      t.string :language
    end
  end

  def down
    change_table :frbr_expressions do |t|
      t.remove :version, :language
    end
  end
end
