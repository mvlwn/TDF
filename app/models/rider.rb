class Rider < ActiveRecord::Base

  attr_accessor :sorted_points

  has_many :scores, :dependent => :destroy
  has_many :player_riders, :dependent => :destroy
  has_many :players, :through => :player_riders
  has_many :rider_stages, dependent: :destroy
  has_many :stages, through: :rider_stages
  belongs_to :team
  belongs_to :last_stage, class_name: 'Stage', foreign_key: :stage_id
  
  validates :first_name, :last_name, :team_id, :price, :presence => true

  before_save :update_team_name, :update_abandoned
  before_create :set_ad_code
  before_update :handle_number_update, :set_efficiency
  after_update :update_player_points, :update_team_name

  scope :active, -> { where(:rejected => false) }
  scope :abandoned, -> { where(:abandoned => true) }

  def self.riders_picked
    Rider.joins(:player_riders).group(:rider_id).count(:rider_id).size
  end
  
  def self.most_popular_rider
    Rider.select("riders.*").joins(:player_riders).group("riders.id").order("COUNT(rider_id) DESC").first
  end
  
  def self.most_popular_rider_picked
    most_popular_rider.player_riders.count
  end

  def stage_points(stage)
    if last_stage && stage.number <= last_stage.number
      rider_stage = rider_stages.where(stage_id = stage.id).first
      rider_stage.points if rider_stage
    end
  end

  def substitute_price
    p = price.to_i * 0.5
    if p > 500
      p
    else
      500
    end
  end

  def update_player_points
    PlayerRider.where('rider_id = ? OR substitute_rider_id = ?', id, id).each do |player_rider|
      player_rider.count_points
    end
  end

  # Update all scores where no rider_id is present, and where the number corresponds. Set the rider_id, and update the points
  def handle_number_update
    if number_changed?
      Score.where(number: self.number).update_all(rider_id: self.id)
      self.points = scores.sum(:points)
    end
  end

  def update_team_name
    if team_id_changed?
      self.team_name = self.team.name
    end
  end

  def update_abandoned
    self.abandoned = stage_id.present?
    true
  end

  def set_ad_code
    if self.ad_code.blank?
      self.ad_code = self.class.maximum(:ad_code) + 1
    end
  end

  def set_efficiency
    self.efficiency_in_cents = ((price * Player::BUDGET_MULTIPLIER / points) rescue price * Player::BUDGET_MULTIPLIER) * 100
  end

  def self.filter_riders(riders, params)
    if params[:name].present?
      riders = riders.where(["CONCAT(first_name, ' ', last_name) LIKE ?", "%#{params[:name]}%"])
      @search = true
    end

    if params[:team_id].present?
      riders = riders.where(:team_id => params[:team_id])
      @search = true
    end

    if params[:price_from].present?
      riders = riders.where(["price >= ?", params[:price_from]])
      @search = true
    end

    if params[:price_to].present?
      riders = riders.where(["price <= ?", params[:price_to]])
      @search = true
    end

    riders

  end
  
end
