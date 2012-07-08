class RankingsController < ApplicationController

  def index
    @stage = StageDecorator.decorate(Stage.last_stage)
    @players = PlayerDecorator.decorate(Player.active.order("points DESC"))
    @riders = RiderDecorator.decorate(Rider.active.order("points DESC"))

    # Selected player
    player = Player.find_by_id(params[:player_id]) || current_player || @players.first
    @player = PlayerDecorator.decorate(player)
  end

end
