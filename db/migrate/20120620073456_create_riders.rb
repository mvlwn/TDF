class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
      t.integer :team_id
      t.string :team_name
      t.integer :number
      t.integer :ad_code, :null => false
      t.string :ad_role, :size => 1
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.integer :price, :null => false
      t.integer :points, :default => 0
      t.boolean :confirmed, :default => false
      t.boolean :rejected, :default => false
      t.timestamps
    end

    add_index "riders", ["ad_code"], name: "index_riders_on_ad_code", using: :btree
    add_index "riders", ["number"], name: "index_riders_on_number", using: :btree
    add_index "riders", ["stage_id"], name: "index_riders_on_stage_id", using: :btree
    add_index "riders", ["team_id"], name: "index_riders_on_team_id", using: :btree
  end
end
