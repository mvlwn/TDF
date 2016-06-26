class SummaryController < ApplicationController

  before_filter :check_sign_in, only: [:show]
  before_filter :check_race_started, only: [:show]

  def show

    @riders_count = Rider.count
    @stages = StageDecorator.decorate_collection(Stage.order("id"))

    # Stage results
    stage = Stage.last_stage || Stage.order("number").first

    if stage.nil?
      redirect_to :action => :not_found and return
    end

    @stage = stage.decorate
    @stage_players = sort_players_by_stage_points(PlayerDecorator.decorate_collection(Player.active), @stage).shift(10)
    @stage_riders = sort_riders_by_stage_points(RiderDecorator.decorate_collection(Rider.active), @stage).shift(10)

    # Overall results
    @players = PlayerDecorator.decorate_collection(Player.active.order("points DESC").limit(10))
    @riders = RiderDecorator.decorate_collection(Rider.active.order("points DESC").limit(10))

    # Selected player
    if params[:player_id]
      player = Player.find_by(id: params[:player_id])
    else
      player = current_player || @stage_players.first
    end

    @player = player.decorate
  end

  def signup
    redirect_to new_session_path(:player)
  end

  def not_found

  end

  private

  def check_sign_in
    if player_signed_in?
      true
    else
      redirect_to new_session_path(:player)
    end
  end

  def check_race_started
    if race_started?
      true
    else
      redirect_to account_path
    end
  end

end
