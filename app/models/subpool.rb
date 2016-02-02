class Subpool < ActiveRecord::Base

  has_many :subpool_players, dependent: :destroy
  has_many :players, :through => :subpool_players
  belongs_to :creator, class_name: 'Player', foreign_key: :creator_id

  validates_uniqueness_of :name
  validates_presence_of :name, :creator_id

  def creator?(player)
    creator.id == player.id
  end

end
