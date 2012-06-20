ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

def clean_mongodb
  Rails.logger.debug "cleaning mongodb...."
  Mongoid.database.collections.each do |collection|
    unless collection.name =~ /^system\./
      collection.remove
    end
  end
  Rails.logger.debug "finished cleaning mongodb."
end

class ActiveSupport::TestCase

  # Add more helper methods to be used by all tests here...
  teardown :clean_mongodb

end
