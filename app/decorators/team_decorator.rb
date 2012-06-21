class TeamDecorator < Draper::Base
  decorates :team
  decorates_association :riders
end
