require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Statistiques < WindowSudoku

	def initialize(joueur)
		super("Statistiques")

		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 205, :heigth => 200)))
		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)

		#Création du label
		labelScore = Gtk::Label.new("Voici vos scores : ")
		score = Gtk::Label.new(joueur.afficherScore)

		#Création des boutons
		retour = Gtk::Button.new(:label => "Retour")
		retour.override_background_color(:normal, @colorNeutral)
		retour.set_size_request(205,50)

		#Redirection des boutons
		retour.signal_connect "clicked" do |widget|
			hide
			newWindow=MenuProfil.new
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(labelScore, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(score, 0, 10, 4, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 0, 10, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end