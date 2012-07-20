class TeamDecorator < Draper::Base
  decorates :team
  decorates_association :riders

  def budget
    h.number_to_euro(team.budget * Player::BUDGET_MULTIPLIER)
  end

  def points
    team.riders.sum(:points)
  end

end
