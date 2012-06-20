class Rider < ActiveRecord::Base

  belongs_to :team
  has_many :scores
  
  validates :number, :name, :team_id, :presence => true

  def name
    first_name.to_s + ' ' + last_name.to_s
  end

  def stage_points(stage)
    
  end
  
end
