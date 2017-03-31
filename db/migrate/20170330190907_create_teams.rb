class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :team_sport
      t.string :team_name
      t.binary :team_logo

      t.timestamps
    end
  end
end
