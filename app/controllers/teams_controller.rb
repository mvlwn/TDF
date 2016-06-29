class TeamsController < ApplicationController

  load_and_authorize_resource

  def index
    @teams = TeamDecorator.decorate_collection(@teams.order(:name))
  end

  def show
    @riders = RiderDecorator.decorate_collection(@team.riders.order(riders_sort_order))
    @team = @team.decorate
  end

  def edit

  end

  def update
    if @team.update_attributes(team_params)
      flash[:notice] = "Team aangepast"
      redirect_to team_path(@team)
    else
      render :action => :edit
    end

  end

  private

  def team_params
    params.require(:team).permit(:name, { riders_attributes: [ :price, :number, :confirmed, :rejected, :abandoned, :id] })
  end



end
