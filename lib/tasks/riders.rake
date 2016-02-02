namespace :riders do
  desc 'Destroy all teams and riders, and load new from the riders file'
  task :reset => :environment do
    Team.destroy_all
    update_riders
  end

  desc 'Only update the riders with new information'
  task :update => :environment do
    update_riders
  end

  # Load new teams and riders or update them
  def update_riders
    riders_file = Rails.root.join("vendor", "files", "rennerslijst_2015.txt")
    RiderTextParser.new(File.new(riders_file, 'r').read).parse
  end
end
