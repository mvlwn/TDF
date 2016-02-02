class AddAbandonedStageIdToRiders < ActiveRecord::Migration
  def change
    add_column :riders, :stage_id, :integer
    add_index :riders, :stage_id
  end
end
