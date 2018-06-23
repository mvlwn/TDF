# encoding: utf-8

# Create Teams and Riders
# Read a txt file with riders in tab delimited text format
puts "Creating or updating teams and riders"
SyncScoritoRiders.new.sync!

puts "Creating or updating stages"
# Create Stages
[
  { :number => 1,  :ridden_on => "2018-07-07", :name => "Noirmoutier-en-l’Île – Fontenay-le-Comte", :description => "Vlak", :distance => "201" },
  { :number => 2,  :ridden_on => "2018-07-08", :name => "Mouilleron-Saint-Germain – La-Roche-sur-Yon", :description => "Vlak", :distance => "182,5" },
  { :number => 3,  :ridden_on => "2018-07-09", :name => "Cholet – Cholet", :description => "Ploegentijdrit", :distance => "35,5" },
  { :number => 4,  :ridden_on => "2018-07-10", :name => "La Baule – Sarzeau", :description => "Vlak", :distance => "195" },
  { :number => 5,  :ridden_on => "2018-07-11", :name => "Lorient – Quimper", :description => "Heuvels", :distance => "204,5" },
  { :number => 6,  :ridden_on => "2018-07-12", :name => "Brest – Mûr de Bretagne", :description => "Heuvels", :distance => "181" },
  { :number => 7,  :ridden_on => "2018-07-13", :name => "Fougéres – Chartres", :description => "Vlak", :distance => "231" },
  { :number => 8,  :ridden_on => "2018-07-14", :name => "Dreux – Amiens", :description => "Vlak", :distance => "181" },
  { :number => 9,  :ridden_on => "2018-07-15", :name => "Arras – Roubaix", :description => "Kasseien", :distance => "156,5" },
  { :number => 10, :ridden_on => "2018-07-17", :name => "Annecy – Le Grand-Bornand", :description => "Bergen", :distance => "158,5" },
  { :number => 11, :ridden_on => "2018-07-18", :name => "Albertville – La Rosière", :description => "Bergen", :distance => "108,5" },
  { :number => 12, :ridden_on => "2018-07-19", :name => "Bourg-Saint-Maurice – Alpe d’Huez", :description => "Bergen", :distance => "175,5" },
  { :number => 13, :ridden_on => "2018-07-20", :name => "Bourg d’Oisans – Valence", :description => "Vlak", :distance => "169,5" },
  { :number => 14, :ridden_on => "2018-07-21", :name => "Saint-Paul-Trois-Chateaux – Mende", :description => "Heuvels/Vlak", :distance => "188" },
  { :number => 15, :ridden_on => "2018-07-22", :name => "Millau – Carcassonne", :description => "Heuvels", :distance => "181,5" },
  { :number => 16, :ridden_on => "2018-07-24", :name => "Carcassonne – Bagnères-de-Luchon", :description => "Bergen/Vlak", :distance => "218" },
  { :number => 17, :ridden_on => "2018-07-25", :name => "Bagnères-de-Luchon – Col de Portet", :description => "Bergen", :distance => "65" },
  { :number => 18, :ridden_on => "2018-07-26", :name => "Trie-sur-Baïse – Pau	", :description => "Vlak", :distance => "171" },
  { :number => 19, :ridden_on => "2018-07-27", :name => "Lourdes – Laruns", :description => "Bergen", :distance => "200,5" },
  { :number => 20, :ridden_on => "2018-07-28", :name => "Saint-Pée-sur-Nivelle – Espelette", :description => "Tijdrit", :distance => "31" },
  { :number => 21, :ridden_on => "2018-07-29", :name => "Houilles – Champs-Élysées (Parijs)", :description => "Vlak", :distance => "116" }
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
