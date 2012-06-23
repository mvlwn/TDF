class PlayersController < ApplicationController

  load_and_authorize_resource

  def index
    @players = PlayerDecorator.decorate(Player.page(params[:page]))
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
    if @player.update_attributes(params[:player])
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
    @stages = StageDecorator.decorate(Stage.all)
  end

  def riders
    @player = PlayerDecorator.decorate(@player)
  end

end
