class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :sorted_points

  BUDGET = 20_000_000
  BUDGET_MULTIPLIER = 1
  MAX_RIDERS = 9
  MAX_EDIT_TIME = Time.parse("01-07-2017 14:30")

  has_many :player_riders
  has_many :player_stage_points
  has_many :player_rider_stage_points
  has_many :riders, :through => :player_riders
  has_many :substitute_riders, :through => :player_riders
  has_many :scores, :through => :riders

  has_many :subpool_players
  has_many :subpools, :through => :subpool_players

  validates :name, :presence => true, :uniqueness => true
  validates :team_name, :presence => true, :uniqueness => true


  scope :active, -> { where(:disabled => false) }

  after_update :clear_team_if_disabled

  def self.budget
    BUDGET * BUDGET_MULTIPLIER
  end

  def self.stage_points(stage)
    Player.
      joins(:riders, :scores).
      select("players.id, players.team_name, SUM(scores.points) AS stage_points").
      where(["scores.stage_id = ?", stage.id]).
      group("players.id").
      order("SUM(scores.points) DESC")
  end

  def stage_points(stage)
    player_stage_points_by_stage(stage).points
  end

  def player_stage_points_by_stage(stage)
    player_stage_points.where(stage_id: stage.id).first
  end


  def active_riders(stage)
    riders = player_riders.map do |player_rider|
      rider = player_rider.rider
      substitute_rider = player_rider.substitute_rider
      if rider.last_stage.nil? || rider.last_stage.number >= stage.number
        rider
      else
        if substitute_rider && (substitute_rider.last_stage.nil? || substitute_rider.last_stage.number >= stage.number)
          substitute_rider
        end
      end
    end.compact
  end

  def budget
    BUDGET
  end

  def expenses
    riders.sum(:price)
  end

  def minimal_expected_expenses
    (MAX_RIDERS - riders.count - 1) * 500_000
  end

  def budget_left
    budget - expenses
  end

  def budget_left_for_purchases
    budget_left - minimal_expected_expenses
  end

  def budget_left?
    budget_left > 0
  end

  def max_riders
    MAX_RIDERS
  end

  def riders_to_pick
    MAX_RIDERS - riders.count
  end

  def can_pick_riders?
    MAX_RIDERS > riders.count
  end

  def can_pick_rider?(rider)
    can_pick_riders? && rider.model.price.to_i <= budget.to_i && !rider_ids.include?(rider.id)
  end

  def available_riders
    _riders = Rider.where(["price <= ?", budget])
    if riders.count > 0
      _riders = _riders.where(["riders.id NOT IN (?)", rider_ids])
    end
    _riders
  end

  def team_ready?
    MAX_RIDERS == riders.count && budget >= 0
  end

  def rider_in_team?(rider)
    rider_ids.include?(rider.id)
  end

  def ranking
    Player.order("points DESC").select(:id).collect(&:id).index(id) + 1
  end

  def clear_team_if_disabled
    if self.disabled?
      player_riders.destroy_all
    end
  end

end
