class RankingsController < ApplicationController

  def index
    @stage = Stage.last_stage

    if @stage.nil?
      redirect_to summary_path, :notice => 'Geen ritten gevonden' and return
    end
      
    @stage = @stage.decorate
    @players = PlayerDecorator.decorate_collection(Player.active.order("points DESC"))
    @riders = RiderDecorator.decorate_collection(Rider.active.order("points DESC"))

    # Selected player
    player = Player.where(id: params[:player_id]).first || current_player || @players.first
    @player = player.decorate
  end

  def scores
    @stages = StageDecorator.decorate_collection(Stage.order("number"))
    @players = PlayerDecorator.decorate_collection(Player.active.order("points DESC"))
    @matrix = ScoreMatrix.new
  end


end
