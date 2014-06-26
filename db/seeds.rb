# encoding: utf-8

# Create Teams and Riders
# Read a txt file with riders in tab delimited text format
riders_file = Rails.root.join("vendor", "files", "rennerslijst_2014.txt")
RiderTextParser.new(File.new(riders_file, 'r').read).parse

# Create Stages
Stage.create([
  {:number => 1,  :name => "Leeds > Harrogate",                   :ridden_on => "2014-07-05", :description => "Vlak", :distance => "190"},
  {:number => 2,  :name => "York > Sheffield",                    :ridden_on => "2014-07-06", :description => "Heuvel", :distance => "201"},
  {:number => 3,  :name => "Cambridge > London",                  :ridden_on => "2014-07-07", :description => "Vlak", :distance => "155"},
  {:number => 4,  :name => "Le Touqet-Paris-Plage > Lille",       :ridden_on => "2014-07-08", :description => "Vlak", :distance => "163"},
  {:number => 5,  :name => "Leper > Arenberg / Porte du Hainaut", :ridden_on => "2014-07-09", :description => "Kasseien", :distance => "156"},
  {:number => 6,  :name => "Arras > Reims",                       :ridden_on => "2014-07-10", :description => "Vlak", :distance => "194"},
  {:number => 7,  :name => "Epernay > Nancy",                     :ridden_on => "2014-07-11", :description => "Vlak", :distance => "234"},
  {:number => 8,  :name => "Tomblaine > Gerardmer / La Mauselaine", :ridden_on => "2014-07-12", :description => "Vlak, Bergaankomst", :distance => "161"},
  {:number => 9,  :name => "Gerardmer > Mulhouse",                :ridden_on => "2014-07-13", :description => "Berg", :distance => "170"},
  {:number => 10, :name => "Mulhouse > La Planche des Belles Filles", :ridden_on => "2014-07-14", :description => "Berg", :distance => "161"},
  {:number => 11, :name => "Besancon > Oyonnax",                  :ridden_on => "2014-07-16", :description => "Vlak", :distance => "187"},
  {:number => 12, :name => "Bourg-en-Bresse > Saint-Etienne",     :ridden_on => "2014-07-17", :description => "Vlak", :distance => "185"},
  {:number => 13, :name => "Saint-Etienne > Chamrousse",          :ridden_on => "2014-07-18", :description => "Berg", :distance => "197"},
  {:number => 14, :name => "Grenoble > Risoul",                   :ridden_on => "2014-07-19", :description => "Berg", :distance => "177"},
  {:number => 15, :name => "Tallard > Nimes",                     :ridden_on => "2014-07-20", :description => "Vlak", :distance => "222"},
  {:number => 16, :name => "Carcassonne > Bagneres-de-Luchon",    :ridden_on => "2014-07-22", :description => "Berg", :distance => "237"},
  {:number => 17, :name => "Saint-Gaudens > Pla d'Adet",          :ridden_on => "2014-07-23", :description => "Berg", :distance => "124"},
  {:number => 18, :name => "Pau > Hautacam",                      :ridden_on => "2014-07-24", :description => "Berg", :distance => "145"},
  {:number => 19, :name => "Maubourguet > Bergerac",              :ridden_on => "2014-07-25", :description => "Vlak", :distance => "208"},
  {:number => 20, :name => "Bergerac > Perigueux",                :ridden_on => "2014-07-26", :description => "Tijdrit", :distance => "54"},
  {:number => 21, :name => "Evry > Parijs",                       :ridden_on => "2014-07-27", :description => "Vlak", :distance => "137"}
])

player = Player.create({
  :name => "Martijn van Leeuwen",
  :team_name => "Tijn's Toerders",
  :email => "mail@martijnvanleeuwen.nl",
  :password => "toerdepoele",
  :password_confirmation => "toerdepoele",
  :admin => true
})

player = Player.create({
  :name => "Bastiaan Langeveld",
  :team_name => "GoGesink",
  :email => "bezlangeveld@hotmail.com",
  :password => "toerdepoele",
  :password_confirmation => "toerdepoele",
  :admin => true
})
