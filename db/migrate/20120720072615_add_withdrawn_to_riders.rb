class AddWithdrawnToRiders < ActiveRecord::Migration
  def change
    add_column :riders, :withdrawn, :boolean, :default => false
  end
end
