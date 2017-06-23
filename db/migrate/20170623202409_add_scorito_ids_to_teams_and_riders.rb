class AddScoritoIdsToTeamsAndRiders < ActiveRecord::Migration
  def change
    add_column :teams, :scorito_id, :integer
    add_column :riders, :scorito_id, :integer
    add_column :riders, :scorito_team_id, :integer

    add_index :teams, :scorito_id
    add_index :riders, :scorito_id
    add_index :riders, :scorito_team_id
  end
end
