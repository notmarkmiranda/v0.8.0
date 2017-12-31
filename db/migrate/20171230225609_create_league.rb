class CreateLeague < ActiveRecord::Migration[5.1]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :slug
      t.references :club, foreign_key: true
      t.boolean :privated, default: true

      t.timestamps null: false
    end
  end
end
