class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :rider_id
      t.integer :stage_id
      t.integer :category
      t.integer :points
      t.timestamps
    end
  end
end
