class RidersController < ApplicationController

  load_and_authorize_resource

  respond_to :html

  def index
    @riders = RiderDecorator.decorate(Rider.filter_riders(Rider.order(riders_sort_order), params).page(params[:page]))
  end

  def show
    @rider = RiderDecorator.decorate(Rider.find(params[:id]))
  end

  def new
  end

  def create
    @rider.attributes = params[:rider]
    @rider.save
    respond_with(@rider, :notice => "Renner aangemaakt")
  end

  def edit
  end

  def update
    if @rider.update_attributes(params[:rider])
      redirect_to rider_path(@rider), :notice => "Renner opgeslagen"
    else
      render :action => "edit"
    end
  end

end
