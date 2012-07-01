class TeamsController < ApplicationController

  load_and_authorize_resource

  def index
    @teams = TeamDecorator.decorate(@teams)
  end

  def show
    @team = TeamDecorator.decorate(@team)
    @riders = RiderDecorator.decorate(@team.riders.order(riders_sort_order))
  end

  def edit

  end

  def update
    if @team.update_attributes(params[:team])
      flash[:notice] = "Team aangepast"
      redirect_to team_path(@team)
    else
      render :action => :edit
    end

  end

end
