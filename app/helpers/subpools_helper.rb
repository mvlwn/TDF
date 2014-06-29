module SubpoolsHelper

  def available_subpools(player)
    (Subpool.all - player.subpools).collect{ |s| [s.name, s.id] }
  end

end
