class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :team_name, :email, :password, :password_confirmation, :remember_me

  BUDGET = 100
  BUDGET_MULTIPLIER = 100000
  MAX_RIDERS = 9
  MAX_EDIT_TIME = DateTime.new(2012,6,30.5)

  has_many :player_riders
  has_many :riders, :through => :player_riders
  has_many :scores, :through => :riders

  validates :name, :team_name, :presence => true, :uniqueness => true


  def stage_points(stage)
    riders.joins(:scores).where("scores.stage_id" => stage.id).sum("scores.points")
  end

  def points_till_stage(stage)
    riders.
      joins(:scores, "INNER JOIN stages ON scores.stage_id = stages.id").
      where(["SELECT stages.number <= ?", stage.number]).
      sum("scores.points")
  end

  def budget
    BUDGET - expenses
  end

  def expenses
    riders.sum(:price)
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

  def ranking
    Player.order("points DESC").select(:id).collect(&:id).index(id) + 1
  end

end
