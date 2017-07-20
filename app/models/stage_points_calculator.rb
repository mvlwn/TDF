class StagePointsCalculator

  attr_reader :stage

  def self.calculate_all
    Stage.all.order(:number).each do |stage|
      calculate!(stage)
    end
  end

  def self.calculate!(stage)
    new(stage).calculate!
  end

  def initialize(stage)
    @stage = stage
  end

  def calculate!
    ActiveRecord::Base.transaction do
      clear_stage_points
      calculate_points
    end
  end

  def players
    @players ||= Player.includes(player_riders: [:rider, :substitute_rider]).active
  end

  def rider_stages
    RiderStage.includes(:rider).where(stage_id: stage.id)
  end

  def riders
    @riders ||= rider_stages.map{ |rs| rs.rider }
  end

  private

  def clear_stage_points
    PlayerRiderStagePoint.where(stage_id: stage.id).delete_all
    PlayerStagePoint.where(stage_id: stage.id).delete_all
  end

  def calculate_points
    players.each do |player|
      active_riders = player.active_riders(stage)
      active_rider_ids = active_riders.map(&:id)
      points = 0

      rider_stages.select do |rider_stage|
        if active_rider_ids.include?(rider_stage.rider_id)
          points += rider_stage.points
          rider_total_points = PlayerRiderStagePoint.
            where(player_id: player.id, rider_id: rider_stage.rider_id).
            where("stage_number < ?", stage.number).
            sum(:points)

          PlayerRiderStagePoint.create({
                                         player_id: player.id,
                                         stage_id: stage.id,
                                         stage_number: stage.number,
                                         rider_id: rider_stage.rider_id,
                                         points: rider_stage.points,
                                         total_points: rider_total_points + rider_stage.points
                                       })
        end
      end

      total_points =
        PlayerStagePoint.
          where(player_id: player.id).
          where("stage_number < ?", stage.number).
          sum(:points)

      PlayerStagePoint.create({
                                player_id: player.id,
                                stage_id:  stage.id,
                                stage_number: stage.number,
                                points:    points,
                                total_points: total_points + points
                              })
    end
  end

end