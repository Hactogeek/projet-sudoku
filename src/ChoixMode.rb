require 'gtk3'
require "./ChoixDifficulte.rb"
require "./MenuProfil.rb"

class ChoixMode < Gtk::Window

	def initialize
		super()

		signal_connect "destroy" do
			Gtk.main_quit
		end

		set_title "Choix du mode"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(919, 602)

		#Création du label
		modeLabel = Gtk::Label.new("Choix du mode : ")

		#Création des boutons
		apprentissage = Gtk::Button.new(:label => "Apprentissage")
		examen = Gtk::Button.new(:label => "Examen")
		retour = Gtk::Button.new(:label => "Retour")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

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

		add(tableMain)
		
		show_all
	end
end