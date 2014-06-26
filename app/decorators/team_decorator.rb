class TeamDecorator < Draper::Decorator
  delegate_all
  delegate :current_page, :total_pages, :limit_value
  # decorates_association :riders

  def budget
    h.number_to_euro(model.budget * Player::BUDGET_MULTIPLIER)
  end

  def points
    model.riders.sum(:points)
  end

end
