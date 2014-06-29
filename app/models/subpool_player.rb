class SubpoolPlayer < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :player
  belongs_to :subpool

end
