class ScoreMatrix

  attr_reader :matrix
  attr_accessor :player_id, :stage_id

  def initialize(player_id = nil, stage_id = nil)
    @matrix = generate_score_matrix
    @player_id = player_id
    @stage_id = stage_id
  end

  def points
    return 0 unless @matrix.has_key?(stage_id)
    @matrix[stage_id][player_id].to_i
  end

  def position
    return nil unless @matrix.has_key?(stage_id)
    pos = sorted_stage_results.index(stage_result)
    pos.nil? ? nil : pos + 1
  end

  def first?
    return false unless @matrix.has_key?(stage_id)
    sorted_stage_results.first == stage_result
  end

  def last?
    return false unless @matrix.has_key?(stage_id)
    sorted_stage_results.last == stage_result
  end

  def generate_score_matrix
    matrix = {}

    scores = Player.joins(:scores).
              group("players.id, stage_id").
              select("players.id AS player_id, stage_id, SUM(scores.points) AS player_points").
              order("stage_id, SUM(scores.points) DESC")

    scores.each do |score|
      matrix[score.stage_id.to_i] = {} unless matrix.has_key?(score.stage_id.to_i)
      matrix[score.stage_id.to_i][score.player_id.to_i] = score.player_points
    end

    matrix
  end

  def sorted_stage_results
    @matrix[stage_id].sort_by{ |player_id, points| points }.reverse
  end

  def stage_result
    [player_id, points]
  end

  def position_string
    if position
      "#{position}e"
    else
      '-'
    end
  end

  def points_string
    if points.to_i > 0
      points.to_s
    else
      '-'
    end
  end

end