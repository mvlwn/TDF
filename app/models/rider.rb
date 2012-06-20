class Rider < ActiveRecord::Base

  belongs_to :team
  has_many :scores
  has_many :player_riders
  has_many :players, :through => :player_riders
  
  validates :ad_code, :ad_role, :first_name, :last_name, :team_id, :presence => true

  before_create :update_team_name
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
  
end
