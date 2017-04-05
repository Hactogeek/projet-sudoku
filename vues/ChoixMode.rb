require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class ChoixMode < WindowSudoku
	def initialize


		super("Choix du mode")

		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 205, :heigth => 200)))

		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)

		#Création du label
		modeLabel = Gtk::Label.new("Choix du mode : ")

		#Création des boutons
		apprentissage = Gtk::Button.new(:label => "Apprentissage")
		apprentissage.override_background_color(:normal, @colorNeutral)
		apprentissage.set_size_request(205,50)
		examen = Gtk::Button.new(:label => "Examen")
		examen.override_background_color(:normal, @colorNeutral)
		examen.set_size_request(205,50)
		retour = Gtk::Button.new(:label => "Retour")
		retour.override_background_color(:normal, @colorNeutral)
		retour.set_size_request(205,50)

		#Redirection des boutons
		apprentissage.signal_connect "clicked" do |widget|
			hide
			newWindow=ChoixDifficulte.new(0)
		end

		examen.signal_connect "clicked" do |widget|
			hide
			newWindow=ChoixDifficulte.new(0)
		end

		retour.signal_connect "clicked" do |widget|
			hide
			newWindow=MenuProfil.new
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(modeLabel, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(apprentissage, 0, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(examen, 0, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 0, 10, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		
		show_all
	end
end