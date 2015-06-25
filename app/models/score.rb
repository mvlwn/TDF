class Score < ActiveRecord::Base
  # attr_accessible :title, :body

  validates_presence_of :number, :category, :ranking, :points, :rider_id
  validates_numericality_of :number, :category, :ranking, :points
  validates_uniqueness_of :number, scope: [:category, :stage_id]
  validates_uniqueness_of :ranking, scope: [:category, :stage_id]

  belongs_to :stage
  belongs_to :rider

  CATEGORIES = {
    1 => 'Gele trui',
    2 => 'Groene trui',
    3 => 'Bolletjes trui',
    4 => 'Rode rugnummers',
    5 => 'Rode Lantaarn'
  }
  YELLOW_CATEGORY_ID = 1
  GREEN_CATEGORY_ID = 2
  DOTTED_CATEGORY_ID = 3
  COMBATIVENESS_CATEGORY_ID = 4
  YELLOW_LAST_CATEGORY_ID = 5

  scope :yellow, -> { where(category: YELLOW_CATEGORY_ID) }
  scope :green, -> { where(category: GREEN_CATEGORY_ID) }
  scope :dots, -> { where(category: DOTTED_CATEGORY_ID) }
  scope :combativeness, -> { where(category: COMBATIVENESS_CATEGORY_ID) }
  scope :yellow_last, -> { where(category: YELLOW_LAST_CATEGORY_ID) }

  validates_presence_of :ranking, :points, :category, :stage_id, :number
  validates_inclusion_of :ranking, :in => 1..50

  after_create :count_points
  after_destroy :count_points
  before_validation :find_rider

  def count_points
    if rider
      rider.update_attribute(:points, rider.scores.sum(:points))
    end
  end

  private

  def find_rider
    rider = Rider.where(number: self.number).first
    if rider
      self.rider_id = rider.id
    else
      self.rider_id = nil
    end
  end

end
