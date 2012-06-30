class AddDisabledToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :disabled, :boolean, :default => false
  end
end
