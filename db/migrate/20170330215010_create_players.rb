class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.integer :team_id
      t.string :player_position
      t.string :player_name
      t.integer :player_age

      t.timestamps
    end
  end
end
