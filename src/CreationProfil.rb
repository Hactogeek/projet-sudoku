require 'gtk3'
require "./MenuProfil.rb"
require "./Joueur.rb"

class CreationProfil < Gtk::Window

	def initialize
		super

		signal_connect "destroy" do
			Gtk.main_quit
		end

		set_title "Creation du profil"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(919, 602)

		#Création du label
		nomLabel = Gtk::Label.new("Nom d'utilisateur : ")
		confirm = Gtk::Label.new("")

		#Création du form
		name = Gtk::Entry.new

		#Création du bouton
		valider = Gtk::Button.new(:label => "Valider")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

		#Redirection des boutons
		valider.signal_connect "clicked" do |widget|
			joueur=Joueur.creer(name.text)
			if(joueur.creerProfil)
				confirm.set_text("Ce profil a déjà été créé. Veuillez en choisir un autre.")
			else
				# Ca marche pas ça. C'est nul
				# confirm.set_text("La création du profil est un succès")
				# sleep(3)
				hide
				newWindow=MenuProfil.new
			end
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nomLabel, 4, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(name, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(confirm, 4, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(valider, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(tableMain)

		show_all
	end
end