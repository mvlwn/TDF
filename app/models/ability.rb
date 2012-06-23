class Ability
  include CanCan::Ability

  def initialize(player)

    player ||= Player.new

    if player.admin?
      can :manage, :all
    else
      can :read, Stage
      can :read, Rider
      can :read, Team
      unless player.new_record?
        can :index, Player

        #cannot :manage, Player do
        #  false
        #end
        #can :index, Player do |p|
        #  false
        #end
        #can :read, Player do |p|
        #  false # (p.try(:id) == player.id && DateTime.now() < Player::MAX_EDIT_TIME) || DateTime.now() > Player::MAX_EDIT_TIME
        #end
        can [:edit, :update, :add_rider, :remove_rider], Player do |p|
          current_player.try(:id) == p.id && DateTime.now() < Player::MAX_EDIT_TIME
        end

      end

    end
  end

end