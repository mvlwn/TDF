class Score < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :stage
  belongs_to :rider
  
  CATEGORIES = [1,2,3]
  CATEGORY_NAMES = ["yellow", "green", "dotted"]

  validates :ranking, :points, :category, :stage_id, :rider_id, :presence => true
  validates :ranking, :uniqueness => { :scope => :stage_id }

  after_create :count_points

  def count_points
    rider.points = rider.scores.sum(:points)
  end

end
