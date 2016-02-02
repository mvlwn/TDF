class AddColumnsToPlayerRiders < ActiveRecord::Migration
  def change
    add_column :player_riders, :substitute_rider_id, :integer
    add_column :player_riders, :points, :integer
    add_index :player_riders, :substitute_rider_id
  end
end
