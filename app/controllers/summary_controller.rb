class SummaryController < ApplicationController

  def index
    @players = Player.all
    @riders_count = Rider.count
    @stages = Stage.order("id")
  end

end
