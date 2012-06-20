class Rider
  include Mongoid::Document
  
  field :number, :type => Integer
  field :code, :type => Integer
  field :first_name, :type => String
  field :last_name, :type => String
  field :team, :type => String
  field :position, :type => String, :size => 1
  field :nationality, :type => String, :size => 2
  field :value, :type => BigDecimal
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  field :stage_points_cache, :type => Hash
  field :points_cache, :type => Integer

  referenced_in :team
  
  validates :number, :name, :team, :presence => true

  def name
    first_name.to_s + ' ' + last_name.to_s
  end

  def stage_points(stage)
    stage.sprint_points.select{|sprint|}
  end
  
end
