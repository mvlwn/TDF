class RemoveAdColumnsFromRiders < ActiveRecord::Migration
  def change
    remove_column :riders, :ad_code
    remove_column :riders, :ad_role
  end
end
