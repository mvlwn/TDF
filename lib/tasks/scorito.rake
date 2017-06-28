require_relative '../../app/models/scorito/client'

namespace :scorito do
  desc 'Save the Scorito riders'
  task :save do
    Scorito::Client.new.save_cache
  end

  desc 'Clear the saved Scorito riders'
  task :clear do
    Scorito::Client.new.clear_cache
  end
end