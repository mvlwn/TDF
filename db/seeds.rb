# encoding: utf-8

# Create Teams and Riders
# Read a txt file with riders in tab delimited text format
riders_file = Rails.root.join("vendor", "files", "riders.txt")
RiderTextParser.new(File.new(riders_file, 'r').read).parse

# Create Stages
Stage.create([
  {:number => 0,  :name => "Proloog Liège > Liège",                       :ridden_on => "2012-06-30", :description => "Proloog",         :distance => "6.4"},
  {:number => 1,  :name => "Liège > Seraing",                             :ridden_on => "2012-07-01", :description => "Vlak",            :distance => "198"},
  {:number => 2,  :name => "Visé > Tournai",                              :ridden_on => "2012-07-02", :description => "Vlak",            :distance => "207.5"},
  {:number => 3,  :name => "Orchies > Boulogne-sur-Mer",                  :ridden_on => "2012-07-03", :description => "Middengebergte",  :distance => "197"},
  {:number => 4,  :name => "Abbeville > Rouen",                           :ridden_on => "2012-07-04", :description => "Vlak",            :distance => "214.5"},
  {:number => 5,  :name => "Rouen > Saint-Quentin",                       :ridden_on => "2012-07-05", :description => "Vlak",            :distance => "196.5"},
  {:number => 6,  :name => "Épernay > Metz",                              :ridden_on => "2012-07-06", :description => "Vlak",            :distance => "207.5"},
  {:number => 7,  :name => "Tomblaine > La Planche des Belles Filles",    :ridden_on => "2012-07-07", :description => "Middengebergte",  :distance => "199"},
  {:number => 8,  :name => "Belfort > Porrentruy",                        :ridden_on => "2012-07-08", :description => "Middengebergte",  :distance => "157.5"},
  {:number => 9,  :name => "Arc-et-Senans > Besançon",                    :ridden_on => "2012-07-09", :description => "Tijdrit",         :distance => "41.5"},
  {:number => 10, :name => "Mâcon > Bellegarde-sur-Valserine",            :ridden_on => "2012-07-11", :description => "Hooggebergte",    :distance => "194.5"},
  {:number => 11, :name => "Albertville > La Toussuire - Les Sybelles",   :ridden_on => "2012-07-12", :description => "Hooggebergte",    :distance => "148"},
  {:number => 12, :name => "Saint-Jean-de-Maurienne > Annonay Davézieux", :ridden_on => "2012-07-13", :description => "Middengebergte",  :distance => "226"},
  {:number => 13, :name => "Saint-Paul-Trois-Châteaux > Le Cap d’Agde",   :ridden_on => "2012-07-14", :description => "Vlak",            :distance => "217"},
  {:number => 14, :name => "Limoux > Foix",                               :ridden_on => "2012-07-15", :description => "Hooggebergte",    :distance => "191"},
  {:number => 15, :name => "Samatan > Pau",                               :ridden_on => "2012-07-16", :description => "Vlak",            :distance => "158.5"},
  {:number => 16, :name => "Pau > Bagnères-de-Luchon",                    :ridden_on => "2012-07-18", :description => "Hooggebergte",    :distance => "197"},
  {:number => 17, :name => "Bagnères-de-Luchon > Peyragudes",             :ridden_on => "2012-07-19", :description => "Hooggebergte",    :distance => "143.5"},
  {:number => 18, :name => "Blagnac > Brive-la-Gaillarde",                :ridden_on => "2012-07-20", :description => "Vlak",            :distance => "222.5"},
  {:number => 19, :name => "Bonneval > Chartres",                         :ridden_on => "2012-07-21", :description => "Tijdrit",         :distance => "53.5"},
  {:number => 20, :name => "Rambouillet > Paris Champs-Élysées",          :ridden_on => "2012-07-22", :description => "Vlak",            :distance => "120"}
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
