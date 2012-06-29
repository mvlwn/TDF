class PlayerRider < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :player
  belongs_to :rider

  validates :rider_id, :player_id, :presence => true
  validates :rider_id, :uniqueness => {:scope => :player_id}
  validates :player_id, :uniqueness => {:scope => :rider_id}
  validate :enough_budget

  after_create :count_points

  def count_points
    player.update_attribute(:points, player.riders.sum(:points))
  end

  def enough_budget
    if rider.price > player.budget
      errors.add(:rider_id, "is te duur")
    end
  end


end
