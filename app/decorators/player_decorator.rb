# encoding: utf-8
class PlayerDecorator < Draper::Decorator
  delegate_all
  delegate :current_page, :total_pages, :limit_value
  # decorates_association :riders

  def name
    h.truncate(model.name, length: 20)
  end

  def team_name
    h.truncate(model.team_name, length: 20)
  end

  def player
    model
  end
  
  def you_badge
    if h.player_signed_in? && player.id == h.current_player.id
      h.content_tag("span", "Jij" , :class => "badge badge-info").html_safe
    end
  end

  def expenses
    h.number_to_euro model.expenses * Player::BUDGET_MULTIPLIER
  end

  def budget
    h.number_to_euro model.budget * Player::BUDGET_MULTIPLIER
  end

  def budget_left
    h.number_to_euro model.budget_left * Player::BUDGET_MULTIPLIER
  end

  def riders_count_label
    badge_class = team_ready? ? "label-success" : "label-danger"
    h.content_tag("span", player.player_riders.count.to_s + " renners", :class => "label #{badge_class}")
  end

  def substitutes_count_label
    badge_class = team_ready? ? "label-success" : "label-warning"
    h.content_tag("span", player.player_riders.where('substitute_rider_id IS NOT NULL').count.to_s + " reserverenners", :class => "label #{badge_class}")
  end

  def paid
    h.bool_icon model.paid
  end

  def link_to
    if h.can? :show, player
      h.link_to h.truncate(model.team_name, length: 20), h.player_path(player)
    else
      h.truncate(model.team_name, length: 20)
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
