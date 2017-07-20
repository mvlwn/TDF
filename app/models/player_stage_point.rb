class PlayerStagePoint < ActiveRecord::Base

  belongs_to :player
  belongs_to :stage

end
