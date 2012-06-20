require 'test_helper'

class StageTest < ActiveSupport::TestCase

  setup do
    @stage = Stage.new(:number => 1)
  end

  def add_points(stage)
    stage.sprint_points =
      [
        {:ranking => 1, :number => 11, :points => 50},
        {:ranking => 2, :number => 21, :points => 25},
        {:ranking => 3, :number => 31, :points => 20}
      ]
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
    add_points(@stage)
    assert @stage.save
    assert @stage.sprint_points.is_a?(Array)
    assert @stage.sprint_points.size == 3
  end

end
