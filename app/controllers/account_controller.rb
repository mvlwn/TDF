class AccountController < ApplicationController

  before_filter :authenticate_player!

  def show
    @player = PlayerDecorator.decorate_collection(current_player)
    @riders = RiderDecorator.decorate_collection(@player.riders.order(riders_sort_order))
  end

end
