class PlayerRider < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :player
  belongs_to :rider

  validates :rider_id, :player_id, :presence => true
  validates :rider_id, :uniqueness => {:scope => :player_id}
  validates :player_id, :uniqueness => {:scope => :rider_id}
  
end
