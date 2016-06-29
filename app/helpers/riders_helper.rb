module RidersHelper

  def link_to_sortable(text, column, options = {})
    text ||= column.titleize
    direction = column.to_s == riders_sort_column && riders_sort_direction == "asc" ? "desc" : "asc"
    link_to text, params.merge(:sort => column, :direction => direction)
  end

  def options_for_select_team_id
    content_tag("option") + options_from_collection_for_select(Team.order(:name), :id, :name, params[:team_id].to_i)
  end

  def options_for_select_price_from
    value = params[:price_from].present? ? params[:price_from].to_i : nil
    content_tag("option") + options_for_select((Rider.minimum(:price)..Rider.maximum(:price)).step(250).to_a.map{|s| ["#{number_to_euro s.to_i * Player::BUDGET_MULTIPLIER}", s]}, value)
  end

  def options_for_select_price_to
    value = params[:price_to].present? ? params[:price_to].to_i : nil
    content_tag("option") + options_for_select((Rider.minimum(:price)..Rider.maximum(:price)).step(250).to_a.map{|s| ["#{number_to_euro s.to_i * Player::BUDGET_MULTIPLIER}", s]}, value)
  end

  def options_for_select_active
    value = params[:active].present? ? params[:active].to_i : 1
    content_tag("option") + options_for_select([['Ja', 1], ['Nee', 0]], value)
  end

end
