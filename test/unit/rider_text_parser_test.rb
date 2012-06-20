require 'test_helper'

class RiderTextParserTest < ActiveSupport::TestCase

  setup do
    @text = "Code	Voornaam	Naam	Ploeg	Type	Waarde\n"
    @text += "100	Vincent	Lavenu	AG2R La Mondiale	P	18\n"
    @text += "200	Jean-Christophe 	Peraud 	AG2R La Mondiale	K	15"
  end
  
  test "create" do
    parser = RiderTextParser.new(@text)
    assert parser.is_a?(RiderTextParser)
    assert parser.input == @text
  end
  
  test "creating without input should read default file" do
    parser = RiderTextParser.new
    assert_not_nil parser.input
  end

  test "parse input and extract riders" do
    parser = RiderTextParser.new(@text)
    parser.parse
    assert parser.riders.is_a?(Array), "riders should be an Array"
    assert parser.riders.count == 2, "there should be only 2 riders"
  end
  
  
end
