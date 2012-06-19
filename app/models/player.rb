class Player
  include Mongoid::Document
  
  field :name, :type => String
  field :team_name, :type => String
  field :riders, :type => Array
  field :points, :type => Integer
  field :rider_points, :type => Hash
  field :stage_points, :type => Hash  
  
  key :name  
  
end
