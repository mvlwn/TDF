require 'test_helper'

class RiderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "creating a rider without attributes fails" do
    rider = Rider.create
    assert rider.new_record?
    assert rider.errors.count > 0
  end
  
  test "setting up a rider" do
    rider = Rider.create(:number => 51, :name => "Robert Gesink", :team => "Rabobank")
    assert rider.number == 51
    assert rider.name == "Robert Gesink"
    assert rider.team == "Rabobank"
  end
  
  test "Finding all teams" do
    Rider.create(:number => 51, :name => "Robert Gesink", :team => "Rabobank")
    assert_match Rider.teams.join(" "), "Rabobank"
  end
  
  test "Parsing riders" do
        
  end
  
  
end
