class CreateUserClubRole < ActiveRecord::Migration[5.1]
  def change
    create_table :user_club_roles do |t|
      t.references :user, foreign_key: true
      t.references :club, foreign_key: true
      t.integer :role, default: 0

      t.timestamps null: false
    end
  end
end
