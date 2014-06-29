class CreateSubpools < ActiveRecord::Migration
  def change
    create_table :subpools do |t|
      t.string :name
      t.integer :creator_id
      t.timestamps
    end
    add_index :subpools, :creator_id
  end
end
