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
      can :read, Score
      can :show, Player do |p|
        Time.now() > Player::MAX_EDIT_TIME
      end
      
      if !player.new_record? && !player.disabled?
        can :index, Player
        cannot [:edit, :pick_substitute, :add_substitute, :remove_substitute, :add_rider, :remove_rider], Player do |p|
          Time.now() > Player::MAX_EDIT_TIME
        end
        can [:show, :edit, :update, :pick_substitute, :add_substitute, :remove_substitute, :add_rider, :remove_rider], Player do |p|
          player.try(:id) == p.id && Time.now() < Player::MAX_EDIT_TIME
        end
      end
    end
  end

end