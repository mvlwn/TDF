class RidersController < ApplicationController

  load_and_authorize_resource

  respond_to :html, :json
  helper_method :rider_params

  def index
    riders = Rider.filter_riders(Rider.order(riders_sort_order), rider_params).page(params[:page])
    @riders = RiderDecorator.decorate_collection(riders)
  end

  def edit_index
    riders = Rider.filter_riders(Rider.order(riders_sort_order), rider_params)
    @riders = RiderDecorator.decorate_collection(riders)
  end

  def update_index
    Rider.update(params[:riders].keys, params[:riders].values)
    redirect_to riders_path(rider_params)
  end

  def show
    @rider = Rider.find(params[:id]).decorate
    @stages = StageDecorator.decorate_collection(Stage.all)
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
      respond_to do |format|
        format.html { redirect_to rider_path(@rider), :notice => "Renner opgeslagen" }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.js {}
      end
    end
  end

  def destroy
    @rider.destroy
    flash[:notice] = "Renner verwijderd"
    redirect_to :back
  end

  def rider_params
    p = {}
    [:name, :price_from, :price_to, :team_id].each do |col|
      p[col] = params[col]
    end
    p
  end

end
