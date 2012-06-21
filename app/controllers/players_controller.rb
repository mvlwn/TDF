class PlayersController < ApplicationController

  def index
    @players = PlayerDecorator.decorate(Player.all)
  end

  def show
    @player = PlayerDecorator.decorate(Player.find(params[:id]))
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])
    if @player.save
      redirect_to player_path(@player), :notice => "Speler aangemaakt"
    else
      render :action => "new"
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      redirect_to player_path(@player), :notice => "Wijzigingen opgeslagen"
    else
      render :action => "edit"
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_path, :notice => "Speler verwijderd"
  end

  def points
    @player = PlayerDecorator.decorate(Player.find(params[:id]))
    @stages = StageDecorator.decorate(Stage.all)
  end

  def riders
    @player = PlayerDecorator.decorate(Player.find(params[:id]))
  end

  def pick
    @player = PlayerDecorator.decorate(Player.find(params[:id]))
    @search = false
    @riders = RiderDecorator.decorate(filter_riders(@player.available_riders))
  end

  def select_rider
    @player = Player.find(params[:id])
    @rider = Rider.find(params[:rider_id])
    if @player.riders << @rider
      redirect_to pick_player_path(@player), :notice => "Renner toegevoegd"
    else
      redirect_to pick_player_path(@player), :error => "Renner kon niet worden toegevoegd"
    end
  end

  def deselect_rider
    @player = Player.find(params[:id])
    @rider = Rider.find(params[:rider_id])
    if @player.riders.delete(@rider)
      redirect_to pick_player_path(@player), :notice => "Renner verwijderd"
    else
      redirect_to pick_player_path(@player), :error => "Renner kon niet worden verwijderd"
    end
  end

  private

  def filter_riders(riders)

    if params[:name].present?
      riders = riders.where(["CONCAT(first_name, ' ', last_name) LIKE ?", "%#{params[:name]}%"])
      @search = true
    end

    if params[:team_id].present?
      riders = riders.where(:team_id => params[:team_id])
      @search = true
    end

    if params[:price_from].present?
      riders = riders.where(["price >= ?", params[:price_from]])
      @search = true
    end

    if params[:price_to].present?
      riders = riders.where(["price <= ?", params[:price_to]])
      @search = true
    end

    riders

  end

end
