# encoding: utf-8

# Create Teams and Riders
# Read a txt file with riders in tab delimited text format
riders_file = Rails.root.join("vendor", "files", "rennerslijst_2015.txt")
RiderTextParser.new(File.new(riders_file, 'r').read).parse

# Create Stages
Stage.create([
 { :number => 1, :name => "Utrecht > Utracht", :ridden_on => "2015-07-04", :description => "Tijdrit", :distance => "13.8" },
 { :number => 2, :name => "Utrecht > Neeltje Jans", :ridden_on => "2015-07-05", :description => "Vlak", :distance => "166" },
 { :number => 3, :name => "Antwerpen > Muur van Hoei", :ridden_on => "2015-07-06", :description => "Heuvels", :distance => "160" },
 { :number => 4, :name => "Seraing > Cambrai", :ridden_on => "2015-07-07", :description => "Kasseien", :distance => "223" },
 { :number => 5, :name => "Arras > Amiens", :ridden_on => "2015-07-08", :description => "Vlak", :distance => "190" },
 { :number => 6, :name => "Abbeville > Le Havre", :ridden_on => "2015-07-09", :description => "Vlak", :distance => "192" },
 { :number => 7, :name => "Livarot > Fougeres", :ridden_on => "2015-07-10", :description => "Vlak", :distance => "191" },
 { :number => 8, :name => "Rennes > Mur-de-Bretagne", :ridden_on => "2015-07-11", :description => "Heuvels", :distance => "181" },
 { :number => 9, :name => "Vannes > Plumelec", :ridden_on => "2015-07-12", :description => "Ploegentijdrit", :distance => "28" },
 { :number => 10, :name => "Tarbes > Arette La Pierre Saint Martin", :ridden_on => "2015-07-14", :description => "Heuvels", :distance => "167" },
 { :number => 11, :name => "Pau > Cauterets", :ridden_on => "2015-07-15", :description => "Berg", :distance => "188" },
 { :number => 12, :name => "Lannemezan > Plateau de Beille", :ridden_on => "2015-07-16", :description => "Berg", :distance => "195" },
 { :number => 13, :name => "Muret > Rodez", :ridden_on => "2015-07-17", :description => "Heuvels", :distance => "199" },
 { :number => 14, :name => "Rodez > Mende", :ridden_on => "2015-07-18", :description => "Heuvels", :distance => "178" },
 { :number => 15, :name => "Mende > Valence", :ridden_on => "2015-07-19", :description => "Heuvels", :distance => "183" },
 { :number => 16, :name => "Bourg-De-Péage > Gap", :ridden_on => "2015-07-20", :description => "Heuvels", :distance => "201" },
 { :number => 17, :name => "Digne-les-Bains > Pra Loup", :ridden_on => "2015-07-22", :description => "Berg", :distance => "161" },
 { :number => 18, :name => "Gap > Saint-Jean-de-Maurienne", :ridden_on => "2015-07-23", :description => "Berg", :distance => "187" },
 { :number => 19, :name => "Saint-Jean-de-Maurienne > La Toussuire", :ridden_on => "2015-07-24", :description => "Berg", :distance => "138" },
 { :number => 20, :name => "Modane > L'Alpe d'Huez", :ridden_on => "2015-07-25", :description => "Berg", :distance => "111" },
 { :number => 21, :name => "Sèvres > Parijs", :ridden_on => "2015-07-26", :description => "Vlak", :distance => "110" }
])

Player.create({
  :name => "Martijn van Leeuwen",
  :team_name => "Tijn's Toerders",
  :email => "mail@martijnvanleeuwen.nl",
  :password => "toerdepoele",
  :password_confirmation => "toerdepoele",
  :admin => true
})

Player.create({
  :name => "Bastiaan Langeveld",
  :team_name => "GoGesink",
  :email => "bezlangeveld@hotmail.com",
  :password => "toerdepoele",
  :password_confirmation => "toerdepoele",
  :admin => true
})
