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
        can [:show, :read], Player do |p|
          Time.now() > Player::MAX_EDIT_TIME
        end
        cannot :edit, :add_rider, :remove_rider do |p|
          Time.now() > Player::MAX_EDIT_TIME
        end
        can [:show, :edit, :update, :add_rider, :remove_rider], Player do |p|
          player.try(:id) == p.id && Time.now() < Player::MAX_EDIT_TIME
        end
      end
    end
  end

end