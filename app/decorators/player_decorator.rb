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

  def paid
    h.bool_icon model.paid
  end

  def paid
    h.bool_icon model.paid
  end

  def link_to
    if h.can? :show, player
      h.link_to model.team_name, h.player_path(player)
    else
      model.team_name
    end
  end

  def toggle_disabled
    h.link_to(
      h.bool_icon(!player.disabled?),
      h.toggle_player_path(player, :attribute => :disabled),
      :method => :put,
      :confirm => "Weet je het zeker? Alle renners zullen uit het team verdwijnen"
    )
  end

  def toggle_paid
    h.link_to(
      h.bool_icon(player.paid),
      h.toggle_player_path(player, :attribute => :paid),
      :method => :put
    )
  end

end
