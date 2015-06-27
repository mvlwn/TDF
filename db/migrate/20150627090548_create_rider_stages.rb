class CreateRiderStages < ActiveRecord::Migration
  def change
    create_table :rider_stages do |t|
      t.integer :rider_id
      t.integer :stage_id
      t.integer :points
      t.timestamps
    end

    add_index(:rider_stages, :rider_id)
    add_index(:rider_stages, :stage_id)
  end
end
