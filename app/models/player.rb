class Player < ActiveRecord::Base
  
  has_many :player_riders
  has_many :riders, :through => :player_riders
  
end
