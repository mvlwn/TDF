class AddScoritoColumnsToRiders < ActiveRecord::Migration
  def change
    add_column :riders, :name, :string
    add_column :riders, :short_name, :string
    add_column :riders, :last_name_prefix, :string
    add_column :riders, :age, :integer
    add_column :riders, :weight, :integer
    add_column :riders, :height, :integer
    add_column :riders, :nationality, :string
    add_column :riders, :nationality_flag_url, :string
    add_column :riders, :team_jersey_url, :string
    add_column :riders, :overall_skill, :integer
    add_column :riders, :time_trial_skill, :integer
    add_column :riders, :sprinting_skill, :integer
    add_column :riders, :punching_skill, :integer
    add_column :riders, :climbing_skill, :integer
    add_column :riders, :hills_skill, :integer
    add_column :riders, :cobblestones_skill, :integer
    add_column :riders, :description, :text
  end
end
