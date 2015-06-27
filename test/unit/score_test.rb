require 'test_helper'

class ScoreTest < ActiveSupport::TestCase

  test "rider_stage" do
    rider = riders(:gesink)
    score = Score.create!(number: rider.number, stage: stages(:one), ranking: 1, category: Score::YELLOW_CATEGORY_ID, points: 20)
    assert score.rider_stage.is_a? RiderStage
  end

  test "count_points" do
    rider = riders(:gesink)
    score = Score.create!(number: rider.number, stage: stages(:one), ranking: 1, category: Score::YELLOW_CATEGORY_ID, points: 20)
    assert_equal 20, rider.reload.points
    assert_equal 20, score.rider_stage.points
  end

  test "count_points with multiple scores for a stage" do
    rider = riders(:gesink)
    Score.create!(number: rider.number, stage: stages(:one), ranking: 1, category: Score::YELLOW_CATEGORY_ID, points: 20)
    score = Score.create!(number: rider.number, stage: stages(:one), ranking: 4, category: Score::GREEN_CATEGORY_ID, points: 10)
    assert_equal 30, rider.reload.points
    assert_equal 30, score.rider_stage.points
  end

  test "count_points with multiple scores for multiple stages" do
    rider = riders(:gesink)
    Score.create!(number: rider.number, stage: stages(:one), ranking: 1, category: Score::YELLOW_CATEGORY_ID, points: 20)
    score = Score.create!(number: rider.number, stage: stages(:two), ranking: 4, category: Score::GREEN_CATEGORY_ID, points: 10)
    assert_equal 30, rider.reload.points
    assert_equal 10, score.rider_stage.points
  end

end
