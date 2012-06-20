class RiderTextParser
    
  attr_accessor :input
  attr_reader :riders
  
  def initialize(input)
    validate_input(input)
    @input = input
  end
  
  def parse
    require 'csv'
    @riders = []
    CSV.parse(@input, :col_sep => "\t", :headers => true) do |row|
      @riders << build_rider(row)
    end
  end

  # 200	Jean-Christophe 	Peraud 	AG2R La Mondiale	K	15
  def build_rider(data)
    Rider.create(
      :code => data[0],
      :first_name => data[1],
      :last_name => data[2],
      :team_name => data[3],
      :position => data[4],
      :value => data[5]
    )
  end

  def validate_input(text)
    # if there are no tabs in the text, it is invalid
    unless text =~ /\t/
      raise ArgumentError.new("No tab found in input text: #{text}")
    end
  end
  
end