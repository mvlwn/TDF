class RidersController < ApplicationController

  load_and_authorize_resource

  respond_to :html, :json
  helper_method :filter_rider_params

  def index
    riders = Rider.filter_riders(Rider.order(riders_sort_order), filter_rider_params).page(params[:page])
    @riders = RiderDecorator.decorate_collection(riders)
  end

  def edit_index
    riders = Rider.filter_riders(Rider.order(riders_sort_order), filter_rider_params)
    @riders = RiderDecorator.decorate_collection(riders)
  end

  def update_index
    Rider.update(params[:riders].keys, params[:riders].values)
    redirect_to riders_path(filter_rider_params)
  end

  def show
    @rider = Rider.find(params[:id]).decorate
    @stages = StageDecorator.decorate_collection(Stage.all)
  end

  def new
  end

  def create
    @rider.attributes = rider_params
    @rider.save
    respond_with(@rider, :notice => "Renner aangemaakt")
  end

  def edit
  end

  def update
    if @rider.update_attributes(rider_params)
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

  protected

  def filter_rider_params
    p = {}
    [:name, :price_from, :price_to, :team_id].each do |col|
      p[col] = params[col]
    end
    p
  end

  def rider_params
    params.require(:rider).permit(:first_name, :last_name, :number, :price, :stage_id, :team_id, :rejected, :confirmed, :ad_code, :ad_role)
  end

end
