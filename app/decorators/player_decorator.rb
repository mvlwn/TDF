# encoding: utf-8
class PlayerDecorator < Draper::Base
  decorates :player
  decorates_association :riders

  def name_with_badge
    if player.id == h.current_player.id
      (player.name + ' ' + h.content_tag("span", "Jij" , :class => "badge badge-info")).html_safe
    else
      player.name
    end
  end

  def expenses
    h.number_to_euro model.expenses * Player::BUDGET_MULTIPLIER
  end

  def budget
    h.number_to_euro model.budget * Player::BUDGET_MULTIPLIER
  end

  def riders_count_badge
    badge_class = team_ready? ? "badge-success" : "badge-warning"
    h.content_tag("span", player.riders.count.to_s + " renners", :class => "badge #{badge_class}")
  end

  def paid
    h.bool_icon model.paid
  end

  def link_to
    if h.can? :edit, Player
      h.link_to model.team_name, h.player_path(player)
    else
      model.team_name
    end
  end

end
