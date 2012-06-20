class ScoreDecorator < Draper::Base
  decorates :score
  decorates_association :rider

  def rider_name
    rider ? rider.name : ".."
  end

end
