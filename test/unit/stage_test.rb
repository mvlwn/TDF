require 'test_helper'

class StageTest < ActiveSupport::TestCase

  def add_points(stage)
    results = [
      {:ranking => 1, :rider => riders(:gesink), :points => 50, :category => 2},
      {:ranking => 2, :rider => riders(:hoogerland), :points => 25, :category => 2}
    ]
    stage.add_scores(results)
  end

  test "a new stage without attributes" do
    assert !Stage.new().valid?, "is not valid"
  end

  test "a stage needs a number to be valid" do
    stage = Stage.new(:number => 2)
    assert stage.valid?
  end

  test "a stage must have a unique number" do
    Stage.create(:number => 2)
    assert !Stage.new(:number => 2).valid?
  end

  test "a stage can have sprint points" do
    stage = stages(:one)
    add_points(stage)
    assert_equal stage.points, 75
  end

end
