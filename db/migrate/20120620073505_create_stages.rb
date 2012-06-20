class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :number
      t.string :name
      t.string :description
      t.float :distance
      t.date :ridden_on
      t.text :yellow_results
      t.text :green_results
      t.text :dotted_results
      t.timestamps
    end
    
    add_index(:stages, :number)
    add_index(:stages, :ridden_on)
    
  end
end
