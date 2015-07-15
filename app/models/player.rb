class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :sorted_points

  BUDGET = 15000
  BUDGET_MULTIPLIER = 1000
  MAX_RIDERS = 9
  MAX_EDIT_TIME = Time.parse("04-07-2015 14:00")

  has_many :player_riders
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
    points = 0
    player_riders.each do |pr|
      points += pr.stage_points(stage).to_i
    end
    points
  end

  def points_till_stage(stage)
    riders.
      joins(:scores, "INNER JOIN stages ON scores.stage_id = stages.id").
      where(["SELECT stages.number <= ?", stage.number]).
      sum("scores.points")
  end

  def budget
    BUDGET
  end

  def expenses
    riders.sum(:price)
  end

  def budget_left
    budget - expenses
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
