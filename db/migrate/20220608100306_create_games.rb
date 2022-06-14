class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.references :player_x, null: false
      t.references :player_o
      t.boolean :over, null: false, default: false
      t.string :cells, array: true

      t.timestamps
    end
  end
end