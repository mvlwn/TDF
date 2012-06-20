require 'test_helper'

class StageResultParserTest < ActiveSupport::TestCase

  setup do
    @text =  "1.	GILBERT Philippe	32	OMEGA PHARMA - LOTTO	4h 41' 31\"		50\n"
    @text += "2.	EVANS Cadel	141	BMC RACING TEAM	4h 41' 34\"	+ 00' 03\"	25"
  end

  test "create" do
    parser = StageResultParser.new(@text)
    assert parser.is_a?(StageResultParser)
    assert parser.input == @text
  end

  test "no argument break the parser" do
    assert_raise do
      StageResultParser.new
    end
  end


  test "parse input and extract riders" do
    parser = StageResultParser.new(@text)
    results = parser.parse
    puts results
    assert results.is_a?(Array)
    assert_equal parser.results.size, 2, "there should be only 2 results"
  end

end
