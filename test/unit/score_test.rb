require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  setup do

  end

  test "The grid" do
    score = Score.sum("points")

    puts score.inspect
  end

end
