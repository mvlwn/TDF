class SubpoolPlayersController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
    @subpool_player = SubpoolPlayer.new(subpool_player_params)
    @subpool_player.player = current_player
    if @subpool_player.save
      flash[:notice] = "Aangemeld bij Subpoele"
      redirect_to account_path
    else
      @player = PlayerDecorator.decorate(current_player)
      @riders = RiderDecorator.decorate_collection(@player.riders.order(riders_sort_order))
      render 'account/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @subpool = Subpool.find(params[:id])
    if @subpool
      @subpool_player = SubpoolPlayer.where(player_id: current_player.id, subpool_id: @subpool.id).first
      if @subpool_player
        @subpool_player.destroy
      end
      flash[:notice] = "Afgemeld bij Subpoele"
    else
      flash[:notice] = "Subpoele bestaat niet"
    end
    redirect_to account_path
  end

  private

  def subpool_player_params
    params.require(:subpool_player).permit(:subpool_id)
  end

end