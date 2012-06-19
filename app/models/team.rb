class Team
  include Mongoid::Document
  
  field :name
  key :name

  references_many :riders
  
end
