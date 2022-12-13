class CreateViewingParties < ActiveRecord::Migration[5.2]
  def change
    create_table :viewing_parties do |t|
      t.integer :movie_id
      t.string :duration
      t.string :time
      t.string :date
    end
  end
end
