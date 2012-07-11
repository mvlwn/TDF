class ScoreMatrixDecorator < Draper::Base
  decorates :score_matrix

  def position
    pos = score_matrix.position
    if pos
      "#{pos}e"
    else
      "-"
    end

  end

end
