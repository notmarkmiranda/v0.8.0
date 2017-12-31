class CreateUserLeagueRole < ActiveRecord::Migration[5.1]
  def change
    create_table :user_league_roles do |t|
      t.references :user, foreign_key: true
      t.references :league, foreign_key: true
      t.integer :role
    end
  end
end
