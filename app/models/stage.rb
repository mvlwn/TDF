class Stage < ActiveRecord::Base
  
  has_many :scores

  validates :number, :uniqueness => true, :presence => true

  def add_scores(list_of_scores)
    list_of_scores.to_a.each do |result|
      scores.create(result)
    end
  end

  def points
    scores.sum(:points)
  end

end
