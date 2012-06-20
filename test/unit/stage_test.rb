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

  test "handling yellow results" do
    results = "1.	GESINK Robert	#{riders(:gesink).number}	OMEGA PHARMA - LOTTO	4h 41' 31\"		50\n"
    results += "2.	EVANS Cadel	#{riders(:hoogerland).number}	BMC RACING TEAM	4h 41' 34\"	+ 00' 03\"	25"

    stage = stages(:one)
    stage.yellow_results = results
    stage.save

    assert_equal stage.scores.count, 2
    assert_equal stage.yellow_scores.count, 2
  end

  test "handling green results" do
    results = "1.	GESINK Robert	#{riders(:gesink).number}	OMEGA PHARMA - LOTTO	4h 41' 31\"		50\n"
    results += "2.	EVANS Cadel	#{riders(:hoogerland).number}	BMC RACING TEAM	4h 41' 34\"	+ 00' 03\"	25"

    stage = stages(:one)
    stage.green_results = results
    stage.save

    assert_equal stage.scores.count, 2
    assert_equal stage.green_scores.count, 2
  end

  test "handling dotted results" do
    results = "1.	GESINK Robert	#{riders(:gesink).number}	OMEGA PHARMA - LOTTO	4h 41' 31\"		50\n"
    results += "2.	EVANS Cadel	#{riders(:hoogerland).number}	BMC RACING TEAM	4h 41' 34\"	+ 00' 03\"	25"

    stage = stages(:one)
    stage.dotted_results = results
    stage.save

    assert_equal stage.scores.count, 2
    assert_equal stage.dotted_scores.count, 2
  end

  test "total points" do
    stage = stages(:one)
    add_points(stage)
    assert_equal stage.points, stage.scores.sum(:points)
  end
end
