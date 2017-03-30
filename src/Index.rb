require 'gtk3'
require "./Connexion.rb"
require "./CreationProfil.rb"
require "./Invite.rb"

class Index < Gtk::Window

	def initialize
		super

		signal_connect "destroy" do
			Gtk.main_quit
		end

		set_title "Index"
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(919, 602)

		#Création des boutons
		seConnecter = Gtk::Button.new(:label => "Se connecter")
		creerProfil = Gtk::Button.new(:label => "Créer un profil")
		sessionInvite = Gtk::Button.new(:label => "Session Invité")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

		#Redirection des boutons
		seConnecter.signal_connect "clicked" do |widget|
			hide
			newWindow=Connexion.new
		end
		creerProfil.signal_connect "clicked" do |widget|
			hide
			newWindow=CreationProfil.new
		end
		sessionInvite.signal_connect "clicked" do |widget|
			hide
			newWindow=Invite.new
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(seConnecter, 4, 6, 2, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(creerProfil, 4, 6, 4, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(sessionInvite, 4, 6, 6, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(tableMain)

		show_all
	end
end