class CreateParticipationTypes < ActiveRecord::Migration
  def change
    create_table :participation_types do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
