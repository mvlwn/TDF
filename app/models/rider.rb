class Rider < ActiveRecord::Base

  belongs_to :team
  has_many :scores
  has_many :player_riders
  has_many :players, :through => :player_riders
  
  validates :first_name, :last_name, :team_id, :price, :presence => true

  before_save :update_team_name
  before_create :set_ad_code
  before_update :handle_number_update
  after_update :update_player_points, :update_team_name

  scope :active, where(:rejected => false)

  def stage_points(stage)
    scores.where(:stage_id => stage.id).sum(:points)
  end

  def update_player_points
    if points_changed?
      players.each do |player|
        player.update_attribute(:points, player.riders.sum(:points))
      end
    end
  end

  # Update all scores where no rider_id is present, and where the number corresponds. Set the rider_id, and update the points
  def handle_number_update
    if number_changed?
      Score.update_all("rider_id = #{self.id}", { :number => self.number })
      self.points = scores.sum(:points)
    end
  end

  def update_team_name
    if team_id_changed?
      self.team_name = self.team.name
    end
  end

  def set_ad_code
    if self.ad_code.blank?
      self.ad_code = self.class.maximum(:ad_code) + 1
    end
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
