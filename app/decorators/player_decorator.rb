class PlayerDecorator < Draper::Base
  decorates :player
  decorates_association :riders

end
