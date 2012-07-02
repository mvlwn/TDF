class StageDecorator < Draper::Base
  decorates :stage
  decorates_association :scores

  def ridden_on
    h.l model.ridden_on, :format => :short
  end

  def distance
    h.number_with_precision model.distance.to_s + " km"
  end

  def link_to_player(player)
    btn_primary = if player.id.to_s == h.params[:player_id] then ' btn-primary' else '' end
    h.link_to "Bekijk", h.stage_path(stage, :player_id => player.id, :anchor => "player_ranking"), :class => "btn btn-mini#{btn_primary}"
  end




end
