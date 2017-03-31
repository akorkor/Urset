class CreateSports < ActiveRecord::Migration[5.0]
  def change
    create_table :sports do |t|
      t.integer :user_id
      t.boolean :soccer
      t.boolean :basketball
      t.boolean :baseball
      t.boolean :football
      t.boolean :tennis
      t.boolean :golf
      t.boolean :volleyball
      t.boolean :rugby
      t.boolean :hockey
      t.boolean :nascar

      t.timestamps
    end
  end
end
