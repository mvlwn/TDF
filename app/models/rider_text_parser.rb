class RiderTextParser
  
  DEFAULT_INPUT_FILE = Rails.root.join("vendor", "input", "files", "rma_rennerslijst_2012_NL.txt")
  
  attr_accessor :input, :riders
  
  def initialize(input)
    validate_input(input)
    @input = input
  end
  
  def parse
    require 'csv'
    CSV.foreach(@input,:col_sep => "\t") do |row|
      
    end
  end

  def validate_input(text)
    # if there are no tabs in the text, it is invalid
    if text =~ /\t/
      raise ArgumentError.new("No tab found in input text")
    end
  end
  
end