class Race
  include Mongoid::Document
  
  field :name, :type => String
  key :name
  references_many :stages
  
end
