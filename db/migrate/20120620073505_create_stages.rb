class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :number
      t.string :name
      t.string :ridden_on
      t.timestamps
    end
    
    add_index(:stages, :number)
    add_index(:stages, :ridden_on)
    
  end
end
