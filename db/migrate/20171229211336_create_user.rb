class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.boolean :invited, default: false
      t.string :token
      t.timestamps null: false
    end
    add_index :users, :token, unique: true
  end
end
