class PlayerRider < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :rider
  
  validates :number, :name, :team, :presence => true

  def name
    first_name.to_s + ' ' + last_name.to_s
  end

  def stage_points(stage)
    
  end
  
end
