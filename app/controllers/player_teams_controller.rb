class PlayerTeamsController < ApplicationController

  load_and_authorize_resource :player, :instance_name => :player, :parent => false

  before_filter :authenticate_player!

  def show
    @player = PlayerDecorator.decorate(@player)
    @riders = RiderDecorator.decorate_collection(@player.riders.order(riders_sort_order))
  end

  def edit
    if @player.can_pick_riders?
      all_riders = Rider.active.order(riders_sort_order).page(params[:page])
      all_riders = all_riders.where(price: 0..@player.budget_left)
      riders = Rider.filter_riders(all_riders, params)
      @riders = RiderDecorator.decorate_collection(riders)
    else
      @riders = []
    end

    @player_riders = PlayerRiderDecorator.decorate_collection(@player.player_riders.joins(:rider).order('riders.price DESC'))
    @player = @player.decorate
  end

  def pick_substitute
    player_rider = PlayerRider.find(params[:player_rider_id])
    all_riders = Rider.active.where.not(id: @player.rider_ids).order(riders_sort_order).page(params[:page])
    all_riders = all_riders.where(price: 0..player_rider.rider.substitute_price)
    riders = Rider.filter_riders(all_riders, params)
    @player_rider = player_rider.decorate
    @riders = RiderDecorator.decorate_collection(riders)
    @player = @player.decorate
  end

  def add_substitute
    @player_rider = PlayerRider.find(params[:player_rider_id])
    @rider = Rider.active.where.not(id: @player.rider_ids).find(params[:rider_id])
    if @rider
      @player_rider.substitute_rider = @rider
      if @player_rider.save
        redirect_to edit_player_team_path(@player)
      else
        flash[:error] = "Renner kon niet worden toegevoegd"
        redirect_to :back
      end
    else
      flash[:error] = "Renner kon niet worden toegevoegd"
      redirect_to :back
    end

  end

  def remove_substitute
    @player_rider = PlayerRider.find(params[:player_rider_id])
    @rider = Rider.find(params[:substitute_rider_id])
    @player_rider.substitute_rider = nil

    if @player_rider.save
      redirect_to edit_player_team_path(@player)
    else
      flash[:error] = "Renner kon niet worden verwijderd"
      redirect_to :back
    end
  end

  def update
  end

  def add_rider
    @rider = Rider.find(params[:rider_id])
    begin
      @player.riders << @rider
      redirect_to :back
    rescue
      flash[:error] = "Renner kon niet worden toegevoegd"
      redirect_to :back
    end
  end

  def remove_rider
    @rider = Rider.find(params[:rider_id])
    if @player.riders.delete(@rider)
      redirect_to :back
    else
      redirect_to :back, :error => "Renner kon niet worden verwijderd"
    end
  end
end
