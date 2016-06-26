# encoding: utf-8

# Create Teams and Riders
# Read a txt file with riders in tab delimited text format
puts "Creating or updating teams and riders"
riders_file = Rails.root.join("vendor", "files", "rennerslijst_2016.txt")
RiderTextParser.new(File.new(riders_file, 'r').read).parse

puts "Creating or updating stages"
# Create Stages
[
  { :number => 1, :name => "Mont Saint-Michel > Utah Beach", :ridden_on => "2016-07-02", :description => "Vlak", :distance => "188" },
  { :number => 2, :name => "Saint Lô > Cherbourg-Octeville", :ridden_on => "2016-07-03", :description => "Vlak, Finish heuvelop", :distance => "183" },
  { :number => 3, :name => "Granville > Angers", :ridden_on => "2016-07-04", :description => "Vlak", :distance => "223" },
  { :number => 4, :name => "Saumur > Limoges", :ridden_on => "2016-07-05", :description => "Vlak", :distance => "237" },
  { :number => 5, :name => "Limoges > Le Lioran", :ridden_on => "2016-07-06", :description => "Heuvel", :distance => "216" },
  { :number => 6, :name => "Arpajon-sur-Cère > Montauban", :ridden_on => "2016-07-07", :description => "Heuvel, vlakke finale", :distance => "190" },
  { :number => 7, :name => "L'Isle-Jourdain > Lac de Payolle", :ridden_on => "2016-07-08", :description => "Bergen, vlakke aanloop", :distance => "162" },
  { :number => 8, :name => "Pau > Bagnères-de-Luchon", :ridden_on => "2016-07-09", :description => "Bergen", :distance => "184" },
  { :number => 9, :name => "Vielha (Spa) > Arcalis (And)", :ridden_on => "2016-07-10", :description => "Bergen", :distance => "184" },
  { :number => 10, :name => "Escaldes-Engordany (And) > Revel", :ridden_on => "2016-07-12", :description => "Bergen, vlakke finale", :distance => "197" },
  { :number => 11, :name => "Carcassonne > Montpellier", :ridden_on => "2016-07-13", :description => "vlak", :distance => "162" },
  { :number => 12, :name => "Montpellier > Mont Ventoux", :ridden_on => "2016-07-14", :description => "Bergen", :distance => "184" },
  { :number => 13, :name => "Bourg-Saint-Andéol > Vallon Pont d'Arc", :ridden_on => "2016-07-15", :description => "Tijdrit", :distance => "37" },
  { :number => 14, :name => "Montélimar > Villard-les-Dombes", :ridden_on => "2016-07-16", :description => "Vlak", :distance => "208" },
  { :number => 15, :name => "Bourg-en-Bresse > Culoz", :ridden_on => "2016-07-17", :description => "Bergen", :distance => "160" },
  { :number => 16, :name => "Moirans-en-Montagne > Bern (Zwi)", :ridden_on => "2016-07-18", :description => "Vlak", :distance => "209" },
  { :number => 17, :name => "Bern (Zwi) > Finhaut-Emosson (Zwi)", :ridden_on => "2016-07-20", :description => "Bergen", :distance => "184" },
  { :number => 18, :name => "Sallanches > Mégève", :ridden_on => "2016-07-21", :description => "Klimtijdrit", :distance => "17" },
  { :number => 19, :name => "Albertville > Saint-Gervais Mont Blanc", :ridden_on => "2016-07-22", :description => "Bergen", :distance => "146" },
  { :number => 20, :name => "Mégève > Morzine", :ridden_on => "2016-07-23", :description => "Bergen", :distance => "146" },
  { :number => 21, :name => "Chantilly > Paris", :ridden_on => "2016-07-24", :description => "Vlak", :distance => "113" }
].each do |stage_attributes|
  stage = Stage.find_or_initialize_by(number: stage_attributes[:number])
  stage.update_attributes(stage_attributes)
end

puts "Creating or updating default users"

martijn = Player.find_or_initialize_by(name: 'Martijn van Leeuwen')
martijn.update_attributes({
  :name => "Martijn van Leeuwen",
  :team_name => "Tijn's Toerders",
  :email => "mail@martijnvanleeuwen.nl",
  :password => "toerdepoele",
  :password_confirmation => "toerdepoele",
  :admin => true
})

bastiaan = Player.find_or_initialize_by(name: 'Bastiaan Langeveld')
bastiaan.update_attributes({
  :name => "Bastiaan Langeveld",
  :team_name => "GoGesink",
  :email => "bezlangeveld@hotmail.com",
  :password => "toerdepoele",
  :password_confirmation => "toerdepoele",
  :admin => true
})
