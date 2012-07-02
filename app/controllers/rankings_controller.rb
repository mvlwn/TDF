class RankingsController < ApplicationController

  def index
    @stage = StageDecorator.decorate(Stage.last_stage)
    @players = PlayerDecorator.decorate(Player.active.order("points DESC"))
    @riders = RiderDecorator.decorate(Rider.active.order("points DESC"))

    # Selected player
    @player = PlayerDecorator.decorate(Player.find_by_id(params[:player_id]) || current_player || @sorted_players.first[1])
  end

end
