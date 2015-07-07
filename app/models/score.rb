class Score < ActiveRecord::Base

  validates_presence_of :number, :category, :points, :rider_id
  validates_numericality_of :number, :category, :points

  belongs_to :stage
  belongs_to :rider

  CATEGORIES = {
    0 => 'Dagklassement',
    1 => 'Gele trui',
    2 => 'Groene trui',
    3 => 'Bolletjes trui',
    4 => 'Rode rugnummers',
    5 => 'Rode Lantaarn'
  }

  DAY_CATEGORY_ID = 0
  YELLOW_CATEGORY_ID = 1
  GREEN_CATEGORY_ID = 2
  DOTTED_CATEGORY_ID = 3
  COMBATIVENESS_CATEGORY_ID = 4
  YELLOW_LAST_CATEGORY_ID = 5

  scope :day, -> { where(category: DAY_CATEGORY_ID) }
  scope :yellow, -> { where(category: YELLOW_CATEGORY_ID) }
  scope :green, -> { where(category: GREEN_CATEGORY_ID) }
  scope :dots, -> { where(category: DOTTED_CATEGORY_ID) }
  scope :combativeness, -> { where(category: COMBATIVENESS_CATEGORY_ID) }
  scope :yellow_last, -> { where(category: YELLOW_LAST_CATEGORY_ID) }

  validates_presence_of :points, :category, :stage_id, :number

  after_save :count_points
  after_destroy :count_points
  before_validation :find_rider

  def count_points
    update_rider_stage_points
    update_rider_points
  end

  def rider_stage
    RiderStage.find_or_initialize_by(rider_id: rider_id, stage_id: stage_id)
  end

  private

  def update_rider_points
    rider.update_attributes!(points: rider.scores.sum(:points))
  end

  def update_rider_stage_points
    score_points = Score.where(rider_id: rider_id, stage_id: stage_id).sum(:points)
    rider_stage.update_attributes!(points: score_points)
  end

  def find_rider
    if number.present?
      rider_from_number = Rider.where(number: self.number).first
      self.rider_id = rider_from_number.try(:id)
    else
      self.rider_id = nil
    end

    true
  end

end
