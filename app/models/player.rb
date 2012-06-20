class Player < ActiveRecord::Base
  
  has_many :player_riders
  has_many :riders, :through => :player_riders
  has_many :scores, :through => :riders

  validates :name, :team_name, :presence => true, :uniqueness => true
  
end
