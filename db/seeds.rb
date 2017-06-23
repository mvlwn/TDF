# encoding: utf-8

# Create Teams and Riders
# Read a txt file with riders in tab delimited text format
puts "Creating or updating teams and riders"
SyncScoritoRiders.new.sync!(false)

puts "Creating or updating stages"
# Create Stages
[
  { :number => 1, :name => "Düsseldorf - Düsseldorf", :ridden_on => "2017-07-01", :description => "Tijdrit", :distance => "14" },
  { :number => 2, :name => "Düsseldorf (Dui) – Luik (Bel)", :ridden_on => "2017-07-02", :description => "Vlak", :distance => "203" },
  { :number => 3, :name => "Verviers (Bel) – Longwy", :ridden_on => "2017-07-03", :description => "Aankomst heuvelop", :distance => "212" },
  { :number => 4, :name => "Mondorf les Bains (Lux) – Vittel", :ridden_on => "2017-07-04", :description => "Vlak", :distance => "207" },
  { :number => 5, :name => "Vittel – La Planche des Belles Filles", :ridden_on => "2017-07-05", :description => "Aankomst bergop", :distance => "160" },
  { :number => 6, :name => "Vesoul – Troyes", :ridden_on => "2017-07-06", :description => "Vlak", :distance => "216" },
  { :number => 7, :name => "	Troyes – Nuits Saint Georges", :ridden_on => "2017-07-07", :description => "Vlak", :distance => "213" },
  { :number => 8, :name => "Dole – Station des Rousses", :ridden_on => "2017-07-08", :description => "Bergen", :distance => "187" },
  { :number => 9, :name => "Nantua – Chambery", :ridden_on => "2017-07-9", :description => "Bergen", :distance => "181" },
  { :number => 10, :name => "Périgueux – Bergerac", :ridden_on => "2017-07-11", :description => "Vlak", :distance => "178" },
  { :number => 11, :name => "Eymet – Pau", :ridden_on => "2017-07-12", :description => "vlak", :distance => "203" },
  { :number => 12, :name => "Pau – Peyragudes", :ridden_on => "2017-07-13", :description => "Bergen", :distance => "214" },
  { :number => 13, :name => "	Saint Girons – Foix", :ridden_on => "2017-07-14", :description => "Bergen", :distance => "101" },
  { :number => 14, :name => "Blagnac – Rodez", :ridden_on => "2017-07-15", :description => "Heuvels", :distance => "181" },
  { :number => 15, :name => "	Laissac Sévérac l’Église – Le Puy en Velay", :ridden_on => "2017-07-16", :description => "Heuvels", :distance => "189" },
  { :number => 16, :name => "Le Puy en Velay – Romans sur Isère", :ridden_on => "2017-07-18", :description => "Heuvels, vlak slot", :distance => "165" },
  { :number => 17, :name => "	La Mure – Serre Chevalier", :ridden_on => "2017-07-19", :description => "Bergen", :distance => "183" },
  { :number => 18, :name => "Briançon – Izoard	", :ridden_on => "2017-07-20", :description => "Bergen", :distance => "179" },
  { :number => 19, :name => "Embrun – Salon de Provence", :ridden_on => "2017-07-21", :description => "Vlak", :distance => "222" },
  { :number => 20, :name => "Marseille - Marseille", :ridden_on => "2017-07-22", :description => "Tijdrit", :distance => "22" },
  { :number => 21, :name => "Montgeron – Parijs", :ridden_on => "2017-07-23", :description => "Vlak", :distance => "103" }
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
