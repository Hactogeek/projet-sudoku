require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class ChoixMode < WindowSudoku
	def initialize
		super("Choix du mode")

		#Création du label
		modeLabel = Gtk::Label.new("Choix du mode : ")

		#Création des boutons
		apprentissage = Gtk::Button.new(:label => "Apprentissage")
		examen = Gtk::Button.new(:label => "Examen")
		retour = Gtk::Button.new(:label => "Retour")

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
		tableMain.attach(modeLabel, 4, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(apprentissage, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(examen, 4, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		
		show_all
	end
end