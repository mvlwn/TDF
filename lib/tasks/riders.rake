namespace :riders do
  task :update => :environment do
    # Destroy all teams and riders
    Team.destroy_all
    # Load new teams and riders
    riders_file = Rails.root.join("vendor", "files", "riders.txt")
    RiderTextParser.new(File.new(riders_file, 'r').read).parse
  end
end