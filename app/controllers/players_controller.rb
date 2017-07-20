class PlayersController < ApplicationController

  load_and_authorize_resource

  def index
    if current_player.admin?
      players = Player.page(params[:page])
    else
      players = Player.active.page(params[:page])
    end
    @players = PlayerDecorator.decorate_collection(players)
  end

  def show
    @player = PlayerDecorator.decorate(@player)
  end

  def new
  end

  def create
    if @player.save
      redirect_to player_path(@player), :notice => "Speler aangemaakt"
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @player.update_attributes(player_params)
      redirect_to player_path(@player), :notice => "Wijzigingen opgeslagen"
    else
      render :action => "edit"
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path, :notice => "Speler verwijderd"
  end

  def points
    @player = PlayerDecorator.decorate(@player)
    @stages = StageDecorator.decorate_collection(Stage.all)
  end

  def riders
    @player = PlayerDecorator.decorate(@player)
  end

  def toggle
    @player.toggle(params[:attribute])
    @player.save
    flash[:notice] = "Deelnemer aangepast"
    redirect_to :back
  end

  def stage_points
    @stage = StageDecorator.decorate(Stage.find(params[:stage_id]))
    @player_rider_stage_points = @player.player_rider_stage_points(@stage)
  end

  private

  def player_params
    params.require(:player).permit(:name, :team_name, :email, :paid, :disabled)
  end

end