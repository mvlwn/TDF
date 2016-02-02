require 'test_helper'

class PlayerRiderTest < ActiveSupport::TestCase

  test 'substitute rider points without a abandonement' do
    player = players(:martijn)
    rider = riders(:gesink)
    substitute_rider = riders(:hoogerland)
    player.riders << rider
    player_rider = player.player_riders.first
    player_rider.update_attributes(substitute_rider: substitute_rider)
    Score.create!(number: rider.number, stage: stages(:one), ranking: 1, category: Score::YELLOW_CATEGORY_ID, points: 20)
    Score.create!(number: substitute_rider.number, stage: stages(:two), ranking: 1, category: Score::YELLOW_CATEGORY_ID, points: 30)

    player_rider.reload

    assert_equal 20, player_rider.points
  end

  test 'substitute rider points with a abandonement' do
    player = players(:martijn)
    rider = riders(:gesink)
    substitute_rider = riders(:hoogerland)
    player.riders << rider
    player_rider = player.player_riders.first
    player_rider.update_attributes!(substitute_rider: substitute_rider)
    rider.update_attributes!(last_stage: stages(:one))
    puts "#1"
    Score.create!(number: rider.number, stage: stages(:one), ranking: 1, category: Score::YELLOW_CATEGORY_ID, points: 20)
    puts "#2"
    Score.create!(number: substitute_rider.number, stage: stages(:two), ranking: 1, category: Score::YELLOW_CATEGORY_ID, points: 30)
    puts "#3"
    player_rider.reload

    assert_equal 50, player_rider.points
  end


end
