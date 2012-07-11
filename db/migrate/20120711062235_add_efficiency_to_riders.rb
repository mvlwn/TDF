class AddEfficiencyToRiders < ActiveRecord::Migration
  def change
    add_column :riders, :efficiency_in_cents, :integer

    Rider.all.each do |rider|
      rider.save
    end
  end
end
