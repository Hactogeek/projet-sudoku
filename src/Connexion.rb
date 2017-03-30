require 'gtk3'
require "./MenuProfil.rb"

class Connexion < Gtk::Window

	def initialize
		super

		signal_connect "destroy" do
			Gtk.main_quit
		end

		set_title "Connexion"
		set_window_position(Gtk::Window::POS_CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(919, 602)

		#Création du label
		nomLabel = Gtk::Label.new("Nom d'utilisateur")

		#Création des boutons
		choixNom = Gtk::Button.new(:label => "Se connecter")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

		#Redirection des boutons
		choixNom.signal_connect "clicked" do |widget|
			hide
			newWindow=MenuProfil.new
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nomLabel, 4, 6, 3, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(choixNom, 4, 6, 5, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(tableMain)

		show_all
	end
end