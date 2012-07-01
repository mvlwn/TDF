class SummaryController < ApplicationController

  def show
    @players = Player.active.order("points DESC")
    @riders_count = Rider.count
    @stages = Stage.order("id")
  end

end
