module RidersHelper

  def link_to_sortable(text, column, options = {})
    text ||= column.titleize
    direction = column.to_s == riders_sort_column && riders_sort_direction == "asc" ? "desc" : "asc"
    link_to text, params.merge(:sort => column, :direction => direction)
  end

  def options_for_select_team_id
    content_tag("option") + options_from_collection_for_select(Team.all, :id, :name, params[:team_id].to_i)
  end

  def options_for_select_price_from
    content_tag("option") + options_for_select((Rider.minimum(:price)..Rider.maximum(:price)).step(2).to_a.map{|s| ["#{number_to_euro s.to_i * 100000}", s]}, params[:price_from].to_i)
  end

  def options_for_select_price_to
    content_tag("option") + options_for_select((Rider.minimum(:price)..Rider.maximum(:price)).step(2).to_a.map{|s| ["#{number_to_euro s.to_i * 100000}", s]}, params[:price_to].to_i)
  end

end
