# encoding: utf-8

# Create Teams and Riders
# Read a txt file with riders in tab delimited text format
riders_file = Rails.root.join("vendor", "files", "riders.txt")
RiderTextParser.new(File.new(riders_file, 'r').read).parse

# Create Stages
Stage.create([
  {:number => 1,  :name => "Porto-Vecchio - Bastia", :ridden_on => "2013-06-29", :description => "Vlak", :distance => "212"},
  {:number => 2,  :name => "Bastia - Ajaccio", :ridden_on => "2012-06-30", :description => "Heuvel", :distance => "154"},
  {:number => 3,  :name => "Ajaccio - Calvi", :ridden_on => "2012-07-01", :description => "Heuvel", :distance => "145"},
  {:number => 4,  :name => "Nice - Nice", :ridden_on => "2012-07-02", :description => "Ploegentijdrit", :distance => "25"},
  {:number => 5,  :name => "Cagnes-sur-Mer - Marseille", :ridden_on => "2012-07-03", :description => "Vlak", :distance => "219"},
  {:number => 6,  :name => "Aix-en-Provence - Montpellier", :ridden_on => "2012-07-04", :description => "Vlak", :distance => "176"},
  {:number => 7,  :name => "Montpellier - Albi", :ridden_on => "2012-07-05", :description => "Vlak", :distance => "205"},
  {:number => 8,  :name => "Castres - Ax-3 Domaines", :ridden_on => "2012-07-06", :description => "Berg", :distance => "194"},
  {:number => 9,  :name => "Saint-Girons - Bagnères-de-Bigorre", :ridden_on => "2012-07-07", :description => "Berg", :distance => "165"},
  {:number => 10,  :name => "Saint-Gildas-des-Bois - Saint-Malo", :ridden_on => "2012-07-09", :description => "Vlak", :distance => "193"},
  {:number => 11, :name => "Avranches - Mont Saint-Michel", :ridden_on => "2012-07-10", :description => "Tijdrit", :distance => "33"},
  {:number => 12, :name => "SaintFougères - Tours", :ridden_on => "2012-07-11", :description => "Vlak", :distance => "218"},
  {:number => 13, :name => "Tours - Saint-Amand-Montrond", :ridden_on => "2012-07-12", :description => "Vlak", :distance => "173"},
  {:number => 14, :name => "Saint-Pourçain-sur-Sioule - Lyon", :ridden_on => "2012-07-13", :description => "Vlak", :distance => "191"},
  {:number => 15, :name => "Givors - Mont Ventoux", :ridden_on => "2012-07-14", :description => "Hooggebergte", :distance => "242"},
  {:number => 16, :name => "Vaison-la-Romaine - Gap", :ridden_on => "2012-07-16", :description => "Heuvel", :distance => "168"},
  {:number => 17, :name => "Embrun - Chorges", :ridden_on => "2012-07-17", :description => "Tijdrit", :distance => "32"},
  {:number => 18, :name => "Gap - Alpe d'Huez", :ridden_on => "2012-07-18", :description => "Berg", :distance => "168"},
  {:number => 19, :name => "Bourg d'Oisans - Le Grand Bornand", :ridden_on => "2012-07-19", :description => "Berg", :distance => "204"},
  {:number => 20, :name => "Annecy - Annecy Semnoz", :ridden_on => "2012-07-20", :description => "Berg", :distance => "125"},
  {:number => 21, :name => "Versailles - Parijs", :ridden_on => "2012-07-21", :description => "Vlak", :distance => "118"}
])

player = Player.create({
  :name => "Martijn van Leeuwen",
  :team_name => "Tijn's Toerders",
  :email => "mail@martijnvanleeuwen.nl",
  :password => "toerdepoele",
  :password_confirmation => "toerdepoele"
})

player.update_attribute(:admin, true)

player = Player.create({
  :name => "Bastiaan Langeveld",
  :team_name => "GoGesink",
  :email => "bezlangeveld@hotmail.com",
  :password => "toerdepoele",
  :password_confirmation => "toerdepoele"
})

player.update_attribute(:admin, true)
