class Stage < ActiveRecord::Base
  
  has_many :scores

  validates :number, :uniqueness => true, :presence => true

  after_save :handle_results

  def yellow_scores
    scores.where(:category => Score::YELLOW_CATEGORY_ID)
  end

  def green_scores
    scores.where(:category => Score::GREEN_CATEGORY_ID)
  end

  def dotted_scores
    scores.where(:category => Score::DOTTED_CATEGORY_ID)
  end

  def add_scores(list_of_scores)
    list_of_scores.to_a.each do |result|
      scores.create(result)
    end
  end

  def points
    scores.sum(:points)
  end

  def has_results?
    !yellow_results.blank? || !green_results.blank? || !dotted_results.blank?
  end

  def handle_results
    parse_results(yellow_results, Score::YELLOW_CATEGORY_ID) if yellow_results_changed?
    parse_results(green_results, Score::GREEN_CATEGORY_ID) if green_results_changed?
    parse_results(dotted_results, Score::DOTTED_CATEGORY_ID) if dotted_results_changed?
  end

  def parse_results(text, category)
    # Clean old scores
    scores.where(:category => category).destroy_all
    results = StageResultParser.new(text).parse
    results.each do |result|
      rider = Rider.find_by_number(result[:number])
      scores.create({
        :number => result[:number],
        :rider => rider,
        :category => category,
        :ranking => result[:ranking],
        :points => result[:points]
      })
    end
  end

end
