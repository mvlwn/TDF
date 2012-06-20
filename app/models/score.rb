class Score < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :stage
  belongs_to :rider
  
  CATEGORIES = [1,2,3]
  CATEGORY_NAMES = ["yellow", "green", "dotted"]
  
end
