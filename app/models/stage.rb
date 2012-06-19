class Stage
  include Mongoid::Document
  
  field :name, :type => String
  field :date, :type => Date
  field :sprint_points, :type => Array
  field :mountain_points, :type => Array
  field :standings_points, :type => Array
  field :extra_points, :type => Array
  
  referenced_in :race
  
end
