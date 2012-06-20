class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|      
      t.string :name
      t.string :team_name
      t.integer :points
      t.timestamps
    end
    
    add_index(:players, :points)    
    
  end
end
