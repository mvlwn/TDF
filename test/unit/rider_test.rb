require 'test_helper'

class RiderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def valid_attributes
    {:number => 11, :first_name => "Robert", :last_name => "Gesink", :team => "Rabobank"}
  end

  def valid_rider(attributes)
    attributes.reverse_merge!(valid_attributes)
    Rider.create(attributes)
  end

  def valid_stage
    Stage.new(:number => 1)
  end
  
  test "creating a rider without attributes fails" do
    rider = Rider.create
    assert !rider.valid?
  end

  test "Finding all teams" do
    Rider.create(valid_attributes)
    assert_match Rider.teams.join(" "), "Rabobank"
  end
  
  test "Parsing riders" do
    RiderTextParser.new.parse
    assert Rider.count > 0
  end

  test "calculating sprint points" do
    rider = valid_rider(:number => 11)
    stage = valid_stage()
    stage.sprint_points = [{:number => 11, :ranking => 1, :points => 50}]
    stage.save
    assert_equal rider.points, 50
  end
  
end
