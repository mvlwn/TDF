require 'test_helper'

class RiderTest < ActiveSupport::TestCase

  test "creating a rider without attributes fails" do
    rider = Rider.create
    assert !rider.valid?
  end

  test "calculating sprint points" do
    rider = riders(:gesink)
    stage = stages(:one)
    stage.add_scores([{:rider => rider, :ranking => 1, :points => 50, :category => 1}])
    assert_equal rider.points, 50
  end

  test "name" do
    rider = riders(:gesink)
    assert_equal rider.name, "Robert Gesink"
  end

  test "update_player_points" do
    rider = riders(:gesink)
    player = players(:bastiaan)
    player.riders << rider
    rider.update_attribute(:points, 50)
    player.reload
    assert_equal player.points, 50
  end

  test "team name should be filled when created" do
    rider = riders(:gesink)
    assert_equal rider.team_name, "Rabobank"
  end
  
end
