class Stage < ActiveRecord::Base
  
  has_many :scores

  validates :number, :uniqueness => true, :presence => true
  
end
