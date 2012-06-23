class AccountController < ApplicationController

  before_filter :authenticate_player!

  def show
    @player = PlayerDecorator.decorate(current_player)
    @riders = RiderDecorator.decorate(@player.riders.order(riders_sort_order))
  end

end
