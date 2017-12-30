class AddPrivateToClub < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :privated, :boolean, default: false
  end
end
