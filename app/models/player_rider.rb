class PlayerRider < ActiveRecord::Base

  belongs_to :player
  belongs_to :rider
  belongs_to :substitute_rider, class_name: 'Rider', foreign_key: :substitute_rider_id

  validates :rider_id, :player_id, presence: true
  validates :rider_id, uniqueness: { scope: :player_id }
  validates :player_id, uniqueness: { scope: :rider_id }
  validate :enough_budget, :valid_rider, :valid_substitute_rider

  after_create :count_points

  def count_points
    if rider.last_stage
      self.points = rider_points(rider, Stage.minimum(:number)..rider.last_stage.number)
      if substitute_rider
        if substitute_rider.last_stage
          self.points += rider_points(substitute_rider, rider.last_stage.number + 1..substitute_rider.last_stage.number)
        else
          self.points += rider_points(substitute_rider, rider.last_stage.number + 1..Stage.maximum(:number))
        end
      end
    else
      self.points = rider_points(rider)
    end

    self.save

    player.update_attribute(:points, player.player_riders.sum(:points))
  end

  def enough_budget
    if rider.price > player.budget
      errors.add(:rider_id, "is te duur")
    end
  end

  def valid_rider
    if new_record?
      if rider.rejected?
        errors.add(:rider_id, "doet niet mee")
      elsif player.rider_ids.include?(rider_id)
        errors.add(:rider_id, "is al gekozen")
      elsif player.substitute_rider_ids.include?(rider_id)
        errors.add(:rider_id, "is al gekozen als reserverenner")
      end
    end
  end

  def valid_substitute_rider
    if substitute_rider_id
      if substitute_rider.rejected?
        errors.add(:substitute_rider_id, "doet niet mee")
      elsif player.rider_ids.include?(substitute_rider_id)
        errors.add(:substitute_rider_id, "is al gekozen")
      elsif player.substitute_rider_ids.include?(substitute_rider_id)
        errors.add(:substitute_rider_id, "is al gekozen als reserverenner")
      end
    end
  end

  private

  def rider_points(rider, stage_number_range = nil)
    rider_stages = RiderStage.joins(:stage).where(rider_id: rider.id)
    rider_stages = rider_stages.where(stages: { number: stage_number_range }) if stage_number_range
    rider_stages.sum(:points)
  end

end
