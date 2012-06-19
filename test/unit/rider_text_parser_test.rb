require 'test_helper'

class RiderTextParserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @text = "Code	Voornaam	Naam	Ploeg	Type	Waarde\n"
    @text += "100	Vincent	Lavenu	AG2R La Mondiale	P	18"
  end
  
  test "create" do
    parser = RiderTextParser.new(@text)
    assert parser.is_a?(RiderTextParser)
    assert parser.input == @text
  end
  
  test "creating input text should fail" do
    assert_raise { RiderTextParser.new() }
  end
  
  
end
