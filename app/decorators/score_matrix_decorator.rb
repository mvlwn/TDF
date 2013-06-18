class ScoreMatrixDecorator < Draper::Decorator

  delegate_all

  def position
    pos = model.position
    if pos
      "#{pos}e"
    else
      "-"
    end

  end

end
