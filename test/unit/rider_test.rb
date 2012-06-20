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
  
end
