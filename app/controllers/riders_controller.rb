class RidersController < ApplicationController

  def index
    @teams = TeamDecorator.decorate(Team.all)
  end

  def show
    @rider = RiderDecorator.decorate(Rider.find(params[:id]))
  end

  def edit
    @rider = Rider.find(params[:id])
  end

  def update
    @rider = Rider.find(params[:id])
    if @rider.update_attributes(params[:rider])
      redirect_to rider_path(@rider), :notice => "Renner opgeslagen"
    else
      render :action => "edit"
    end
  end

  def toggle
    @rider = Rider.find(params[:id])
    if @rider.toggle!(params[:field])
      redirect_to :back, :notice => "Renner opgeslagen"
    else
      redirect_to :back, :error => "Renner kon niet worden opgeslagen"
    end
  end
end
