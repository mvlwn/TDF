class StageResultParser

  attr_accessor :input
  attr_reader :results

  def initialize(input)
    @input = input
    @results = []
  end

  def parse
    require 'csv'
    @results = []
    # Using | as quote char, to ignore real quotes
    CSV.parse(@input, :col_sep => "\t", :quote_char => "|") do |row|
      @results << build_score(row)
    end
    @results
  end

  def build_score(data)
    {
      :ranking => data[0].to_i,
      :number => data[2].to_i,
      :points => data[6].to_i
    }
  end

end