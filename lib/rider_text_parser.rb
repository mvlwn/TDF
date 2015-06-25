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
    CSV.parse(@input, :col_sep => "\t", :headers => false) do |row|
      @riders << build_rider_and_team(row)
    end
  end

  # 200	Jean-Christophe 	Peraud 	AG2R La Mondiale	K	15
  def build_rider_and_team(data)
    team = Team.find_or_create_by_name(data[3])
    rider = Rider.find_or_create_by_ad_code(data[0])
    begin
      rider.update_attributes(
          :first_name => data[1] || 'Missing',
          :last_name => data[2],
          :team => team,
          :ad_role => data[4],
          :price => data[5],
          :confirmed => data[6],
          :number => data[7]
        )
    rescue
      puts rider.errors.full_messages.join(", ")
    end
  end

  def validate_input(text)
    # if there are no tabs in the text, it is invalid
    unless text =~ /\t/
      raise ArgumentError.new("No tab found in input text: #{text}")
    end
  end
  
end