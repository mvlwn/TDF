require 'net/http'

module Scorito
  class Client

    def self.riders
      new.riders
    end

    def initialize
      @url = "https://www.scorito.com/cyclingmanager/teamselectionsearch/byprice?marketId=75&min=0&max=5000000&maxNumberOfResults=500&culture=nl-nl"
      @tmp_file = Rails.root.join('tmp', 'riders.json')
      @file = Rails.root.join('vendor', 'files', 'riders.json')
    end

    def riders
      riders_data.map{ |rider_data| Scorito::Rider.new(rider_data) }
    end

    def clear_cache
      File.delete(@tmp_file) if File.exist?(@tmp_file)
    end

    def save_cache
      source = get_source
      save_to_cache_file(source.force_encoding('UTF-8')) if source
    end

    private

    def get_source
      uri = URI(@url)
      Net::HTTP.get(uri)
    end

    def save_to_cache_file(contents)
      file = File.new(@tmp_file, 'w')
      file << contents
      file.close
    end

    def riders_data
      if File.exist?(@file)
        source = File.read(@file)
      else
        source = nil
      end

      JSON.parse(source) if source
    end

  end
end