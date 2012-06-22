class AccountController < ApplicationController

  before_filter :authenticate_player!

  def show
    @player = PlayerDecorator.decorate(current_player)
  end

end
