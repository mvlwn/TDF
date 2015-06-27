require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  test 'a player can have a team' do
    player = players(:martijn)
    rider = riders(:gesink)
    player.riders << rider
    assert player.player_riders.count == 1
  end


  test 'player points system' do
    player = player_with_team
    stage = stages(:one)
    stage.scores.create!(number: riders(:gesink).number, category: Score::YELLOW_CATEGORY_ID, ranking: 2, points: 20)
    stage.scores.create!(number: riders(:hoogerland).number, category: Score::YELLOW_CATEGORY_ID, ranking: 3, points: 10)
    assert_equal 30, player.points
  end

  def player_with_team
    player = players(:martijn)
    player.riders << riders(:gesink)
    player.riders << riders(:hoogerland)
    player
  end

end
