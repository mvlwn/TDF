class SubpoolsController < ApplicationController

  respond_to :html

  def index
    @subpools = Subpool.order('name')
  end

  def show
    @subpool = Subpool.find(params[:id])

    # Overall results
    @players = PlayerDecorator.decorate_collection(@subpool.players.active.order("points DESC"))
  end

  def create
    @subpool = Subpool.new(subpool_params)
    @subpool.creator = current_player
    if @subpool.save
      SubpoolPlayer.create(subpool: @subpool, player: current_player)
      flash[:notice] = "Subpoele aangemaakt"
      redirect_to account_path
    else
      @player = PlayerDecorator.decorate(current_player)
      @riders = RiderDecorator.decorate_collection(@player.riders.order(riders_sort_order))
      render 'account/show'
    end
  end

  def edit
    @subpool = Subpool.find(params[:id])
    unless @subpool.creator?(current_player)
      flash[:error] = 'Je mag deze subpoele niet wijzigen'
      redirect_to account_path
    end
  end

  def update
    @subpool = Subpool.find(params[:id])
    unless @subpool.creator?(current_player)
      flash[:error] = 'Je mag deze subpoele niet wijzigen'
      redirect_to account_path
    end
    if @subpool.update_attributes(subpool_params)
      flash[:notice] = "Subpoele gewijzigd"
      redirect_to account_path
    else
      @player = PlayerDecorator.decorate(current_player)
      @riders = RiderDecorator.decorate_collection(@player.riders.order(riders_sort_order))
      render 'account/show'
    end
  end

  def destroy
    if Subpool.exists?(params[:id])
      @subpool = Subpool.find(params[:id])
      if @subpool.creator?(current_player)
        @subpool.destroy
        flash[:notice] = 'Subpool verwijderd'
      else
        flash[:error] = 'Subpool kan niet verwijderd worden'
      end
    else
      flash[:error] = 'Subpool bestaat niet'
    end
    redirect_to account_path
  end

  private

  def subpool_params
    params.require(:subpool).permit(:name)
  end

end