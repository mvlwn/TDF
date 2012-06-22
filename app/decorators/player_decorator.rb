# encoding: utf-8
class PlayerDecorator < Draper::Base
  decorates :player
  decorates_association :riders

  def expenses
    h.number_to_euro model.expenses * 100000
  end

  def budget
    h.number_to_euro model.budget * 100000
  end

  def riders_count_badge
    badge_class = team_ready? ? "badge-success" : "badge-warning"
    h.content_tag("span", player.riders.count.to_s + " renners", :class => "badge #{badge_class}")
  end

  def paid
    h.bool_icon model.paid
  end

end
