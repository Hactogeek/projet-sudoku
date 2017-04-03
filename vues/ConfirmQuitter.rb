require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class ConfirmQuit < Gtk::Window

	def initialize(partie)
		super

		signal_connect "destroy" do
			hide
		end

		set_title "Confirmez avant de quitter"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(400, 300)

		#Création du label
		label = Gtk::Label.new("Voulez-vous sauvegarder avant de quitter la partie?")

		#Création du bouton
		oui = Gtk::Button.new(:label => "Oui")
		non = Gtk::Button.new(:label => "Non")
		retour = Gtk::Button.new(:label => "Retour")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

		#Redirection des boutons
		oui.signal_connect "clicked" do |widget|
			partie.stopTemps
			Sauvegarde.savePartie(partie,"partie1")
			hide
			newWindow = MenuProfil.new
		end

		non.signal_connect "clicked" do |widget|
			hide
			newWindow = MenuProfil.new
		end

		retour.signal_connect "clicked" do |widget|
			hide
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(label, 2, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(non, 2, 4, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(oui, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 3, 5, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(tableMain)

		show_all
	end
end