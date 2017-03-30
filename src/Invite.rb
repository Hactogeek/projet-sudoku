require 'gtk3'
require "./ChoixDifficulte.rb"
require "./CreationProfil.rb"

class Invite < Gtk::Window

	def initialize
		super

		signal_connect "destroy" do
			Gtk.main_quit
		end

		set_title "Invité"
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(919, 602)

		#Création des boutons
		nouvellePartie = Gtk::Button.new(:label => "Nouvelle partie")
		importerGrille = Gtk::Button.new(:label => "Importer grille")
		creerProfil = Gtk::Button.new(:label => "Créer un profil")
		methodeRes = Gtk::Button.new(:label => "Méthode de résolutions")
		aPropos = Gtk::Button.new(:label => "A propos")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

		#Redirection des boutons
		nouvellePartie.signal_connect "clicked" do |widget|
			hide
			newWindow=ChoixDifficulte.new
		end
		importerGrille.signal_connect "clicked" do |widget|
		end
		creerProfil.signal_connect "clicked" do |widget|
			hide
			newWindow=CreationProfil.new
		end
		methodeRes.signal_connect "clicked" do |widget|
		end
		aPropos.signal_connect "clicked" do |widget|
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nouvellePartie, 4, 6, 2, 3, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(importerGrille, 4, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(creerProfil, 4, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(methodeRes, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(aPropos, 4, 6, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)


		add(tableMain)

		show_all
	end
end