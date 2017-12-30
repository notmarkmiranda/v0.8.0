class RemovePrivatedFromClub < ActiveRecord::Migration[5.1]
  def up
    remove_column :clubs, :privated
  end

  def down
    add_column :clubs, :privated, :boolean, default: false
  end
end
