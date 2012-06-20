class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
      t.integer :team_id
      t.integer :number
      t.integer :ad_code
      t.string :ad_category, :size => 1
      t.string :first_name
      t.string :last_name
      t.integer :value
      t.integer :points
      t.timestamps
    end
    
    add_index(:riders, :team_id)
    add_index(:riders, :number)
    
  end
end
