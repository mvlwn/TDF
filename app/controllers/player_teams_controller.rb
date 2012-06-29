class PlayerTeamsController < ApplicationController

  load_and_authorize_resource :player, :instance_name => :player, :parent => false

  before_filter :authenticate_player!

  def show
    @player = PlayerDecorator.decorate(@player)
    @riders = RiderDecorator.decorate(@player.riders.order(riders_sort_order))
  end

  def edit
    @player = PlayerDecorator.decorate(@player)
    all_riders = Rider.active.order(riders_sort_order).page(params[:page])
    riders = Rider.filter_riders(all_riders, params)
    @riders = RiderDecorator.decorate(riders)
    @player_riders = RiderDecorator.decorate(@player.riders.order(riders_sort_order))
  end

  def update
  end

  def add_rider
    @rider = Rider.find(params[:rider_id])
    begin
      @player.riders << @rider
      redirect_to :back, :notice => "Renner toegevoegd"
    rescue
      flash[:error] = "Renner kon niet worden toegevoegd"
      redirect_to :back
    end
  end

  def remove_rider
    @rider = Rider.find(params[:rider_id])
    if @player.riders.delete(@rider)
      redirect_to :back, :notice => "Renner verwijderd"
    else
      redirect_to :back, :error => "Renner kon niet worden verwijderd"
    end
  end
end
