class TeamDecorator < Draper::Base
  decorates :team
  decorates_association :riders

  def budget
    h.number_to_euro(team.budget * Player::BUDGET_MULTIPLIER)
  end
end
