class SummaryController < ApplicationController

  def show
    @riders_count = Rider.count
    @stages = StageDecorator.decorate(Stage.order("id"))

    # Stage results
    @stage = StageDecorator.decorate(Stage.last_stage)
    @stage_players = sort_players_by_stage_points(PlayerDecorator.decorate(Player.active), @stage).shift(10)
    @stage_riders = sort_riders_by_stage_points(RiderDecorator.decorate(Rider.active), @stage).shift(10)

    # Overall results
    @players = PlayerDecorator.decorate(Player.active.order("points DESC").limit(10))
    @riders = RiderDecorator.decorate(Rider.active.order("points DESC").limit(10))

    # Selected player
    player = Player.find_by_id(params[:player_id]) || current_player || @stage_players.first
    @player = PlayerDecorator.decorate(player)
  end

end
