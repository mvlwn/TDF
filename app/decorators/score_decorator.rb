class ScoreDecorator < Draper::Decorator
  delegate_all
  delegate :current_page, :total_pages, :limit_value
  decorates_association :rider

  def rider_name
    rider ? rider.name : ".."
  end

end
