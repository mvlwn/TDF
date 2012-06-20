class PlayerRider < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :player
  belongs_to :rider
  
end
