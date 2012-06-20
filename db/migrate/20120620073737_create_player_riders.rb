class CreatePlayerRiders < ActiveRecord::Migration
  def change
    create_table :player_riders do |t|
      t.integer :player_id
      t.integer :rider_id
      t.timestamps
    end
    
    add_index(:player_riders, :player_id)
    add_index(:player_riders, :rider_id)
  end
end
