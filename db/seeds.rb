
# Read a txt file with seed and create riders and teams
riders_file = Rails.root.join("vendor", "files", "rma_rennerslijst_2012_NL.txt")
RiderTextParser.new.parse(File.new(riders_file, 'r').read)