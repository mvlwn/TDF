class SummaryController < ApplicationController

  def show
    @riders_count = Rider.count
    @stages = StageDecorator.decorate_collection(Stage.order("id"))

    # Stage results
    stage = Stage.last_stage || Stage.order("number").first
    @stage = stage.decorate
    @stage_players = sort_players_by_stage_points(PlayerDecorator.decorate_collection(Player.active), @stage).shift(10)
    @stage_riders = sort_riders_by_stage_points(RiderDecorator.decorate_collection(Rider.active), @stage).shift(10)

    # Overall results
    @players = PlayerDecorator.decorate_collection(Player.active.order("points DESC").limit(10))
    @riders = RiderDecorator.decorate_collection(Rider.active.order("points DESC").limit(10))

    # Selected player
    player = Player.find_by_id(params[:player_id]) || current_player || @stage_players.first
    @player = player.decorate
  end

end
