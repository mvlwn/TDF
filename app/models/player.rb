class Player < ActiveRecord::Base
  
  has_many :player_riders
  has_many :riders, :through => :player_riders

  validates :name, :team_name, :presence => true, :uniqueness => true
  
end
