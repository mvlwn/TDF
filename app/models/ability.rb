class Ability
  include CanCan::Ability

  def initialize(player)

    # Allow guests
    player ||= Player.new

    # Admin can do anything
    if player.admin?
      can :manage, :all

    # Guest and other users can view Stages, Riders and Teams
    else
      can :read, Stage
      can :read, Rider
      can :read, Team
      unless player.new_record?
        can :index, Player
        can :show, Player do |p|
          DateTime.now() > Player::MAX_EDIT_TIME
        end
        can [:show, :edit, :update, :add_rider, :remove_rider], Player do |p|
          player.try(:id) == p.id && DateTime.now() < Player::MAX_EDIT_TIME
        end
      end
    end
  end

end