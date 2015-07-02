# encoding: utf-8
class RiderDecorator < Draper::Decorator
  delegate_all
  # decorates_association :players

  def rider
    model
  end
  
  def name
    model.first_name.to_s + ' ' + model.last_name.to_s
  end

  def price
    h.number_to_euro(model.price * Player::BUDGET_MULTIPLIER)
  end

  def substitute_price
    h.number_to_euro(model.substitute_price * Player::BUDGET_MULTIPLIER)
  end

  def role
    model.ad_role
  end

  def number
    if rider.abandoned
      h.content_tag("span", rider.number, :class => "label label-danger", :title => "Renner is uit koers")
    else
      h.content_tag("span", rider.number, :class => "label label-success", :title => "Renner is in koers")
    end
  end

  def team_name(view_mode = :normal, options = {})
    if view_mode.to_sym == :truncate
      h.truncate(model.team_name, :length => (options.delete(:length) || 20))
    else
      model.team_name
    end
  end

  def link_to
    if h.can? :show, rider
      h.link_to name, h.rider_path(rider)
    else
      name
    end
  end

  def team_badge(player = nil)
    return if player.blank?
    if player.rider_in_team?(rider)
      h.content_tag("span", "team", :class => "badge badge-success")
    end
  end
  
  def player_teams
    players.collect{ |player| h.link_to(player.team_name, player) }.join(", ").html_safe
  end

  def efficiency
    h.number_to_euro(rider.efficiency_in_cents.to_f / 100)
  end

  def abandoned
    rider.abandoned? ? "Ja" : "Nee"
  end

  def in_race
    !rider.abandoned? && !rider.rejected? ? "Ja" : "Nee"
  end

end
