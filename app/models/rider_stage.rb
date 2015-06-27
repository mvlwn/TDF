class RiderStage < ActiveRecord::Base

  belongs_to :rider
  belongs_to :stage

  validates_presence_of :rider_id, :stage_id, :points
  validates_numericality_of :rider_id, :stage_id, :points

end
