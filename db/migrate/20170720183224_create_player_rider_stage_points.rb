class CreatePlayerRiderStagePoints < ActiveRecord::Migration
  def change
    create_table :player_rider_stage_points do |t|
      t.integer :player_id
      t.integer :stage_id
      t.integer :rider_id
      t.integer :points
      t.integer :total_points
      t.integer :stage_number
    end
  end
end
