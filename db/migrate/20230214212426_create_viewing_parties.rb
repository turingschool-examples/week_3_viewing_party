class CreateViewingParties < ActiveRecord::Migration[5.2]
  def change
    create_table :viewing_parties do |t|
      t.string :duration
      t.string :time
      t.string :date
      t.references :movie, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
