class Rider
  include Mongoid::Document
  
  field :number, :type => Integer
  field :name, :type => String
  field :team, :type => String
  field :nationality, :type => String, :size => 2
  field :value, :type => BigDecimal
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  field :stage_points, :type => Hash
  field :points, :type => Integer

  referenced_in :team
  
  validates :number, :name, :team, :presence => true  
  
end
