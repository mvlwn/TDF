class Score < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :stage
  belongs_to :rider

  CATEGORIES = { 1 => "yellow", 2 => "green", 3 => "dotted"}
  YELLOW_CATEGORY_ID = 1
  GREEN_CATEGORY_ID = 2
  DOTTED_CATEGORY_ID = 3

  validates_presence_of :ranking, :points, :category, :stage_id, :number
  validates_inclusion_of :ranking, :in => 1..50

  after_create :count_points
  after_destroy :count_points

  def count_points
    if rider
      rider.update_attribute(:points, rider.scores.sum(:points))
    end
  end

end
