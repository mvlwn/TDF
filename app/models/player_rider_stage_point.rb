class PlayerRiderStagePoint < ActiveRecord::Base

  belongs_to :player
  belongs_to :rider
  belongs_to :stage

end
