class RenameWithdrawnToAbandonedOnRiders < ActiveRecord::Migration
  def up
    rename_column :riders, :withdrawn, :abandoned
  end

  def down
    rename_column :riders, :abandoned, :withdrawn
  end
end
