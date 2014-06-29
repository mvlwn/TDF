class CreateSubpoolPlayers < ActiveRecord::Migration
  def change
    create_table :subpool_players do |t|
      t.integer :subpool_id
      t.integer :player_id
      t.timestamps
    end

    add_index :subpool_players, :subpool_id
    add_index :subpool_players, :player_id
  end
end
