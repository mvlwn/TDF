class AddabandonedToRiders < ActiveRecord::Migration
  def change
    add_column :riders, :abandoned, :boolean, :default => false
  end
end
