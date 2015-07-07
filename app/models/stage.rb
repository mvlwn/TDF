class Stage < ActiveRecord::Base

  has_many :scores
  has_many :rider_stages, dependent: :destroy
  has_many :riders, through: :rider_stages

  accepts_nested_attributes_for :scores, allow_destroy: true, reject_if: proc{ |attributes| attributes[:number].blank? }

  validates :number, :uniqueness => true, :presence => true
  validates :name, :description, :distance, :ridden_on, presence: true

  def self.last_stage
    joins(:scores).order("number DESC").first
  end

  def name_with_number
    "#{number}. #{name}"
  end

  def previous
    if number == self.class.minimum(:number)
      self
    else
      self.class.where(:number => number - 1).first
    end
  end

  def next
    if number == self.class.maximum(:number)
      self
    else
      self.class.where(:number => number + 1).first
    end
  end

  def yellow_scores
    scores.yellow
  end

  def green_scores
    scores.green
  end

  def dotted_scores
    scores.dots
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
    scores.count > 0
  end

end
