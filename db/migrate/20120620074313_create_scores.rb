class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :number
      t.integer :rider_id
      t.integer :stage_id
      t.integer :category
      t.integer :ranking
      t.integer :points
      t.timestamps
    end

    add_index(:scores, :number)
    add_index(:scores, :rider_id)
    add_index(:scores, :stage_id)
    add_index(:scores, :category)
  end
end
