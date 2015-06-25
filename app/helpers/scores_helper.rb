module ScoresHelper

  def score_category_options
    Score::CATEGORIES.invert.to_a
  end

end
