class StageDecorator < Draper::Base
  decorates :stage
  decorates_association :scores

end
