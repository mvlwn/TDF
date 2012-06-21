class SummaryController < ApplicationController

  def show
    @players = Player.all
    @riders_count = Rider.count
    @stages = Stage.order("id")
  end

end
