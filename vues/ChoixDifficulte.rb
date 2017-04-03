require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class ChoixDifficulte < Gtk::Window

	def initialize(invite)
		super()

		signal_connect "destroy" do
			Gtk.main_quit
		end

		set_title "Choix de difficulté"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(919, 602)

		#Création du label
		diffLabel = Gtk::Label.new("Difficulté : ")

		#Création des boutons
		facile = Gtk::Button.new(:label => "Facile")
		moyen = Gtk::Button.new(:label => "Moyen")
		difficile = Gtk::Button.new(:label => "Difficile")
		retour = Gtk::Button.new(:label => "Retour")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

		#Redirection des boutons
		facile.signal_connect "clicked" do |widget|
			hide
			newWindow=Fenetre.new(Partie.nouvelle(3))
		end
		moyen.signal_connect "clicked" do |widget|
			hide
			newWindow=Fenetre.new(Partie.nouvelle(4))
		end
		difficile.signal_connect "clicked" do |widget|
			hide
			newWindow=Fenetre.new(Partie.nouvelle(5))
		end

		retour.signal_connect "clicked" do |widget|
			hide
			if(invite==1)
				newWindow=Invite.new
			else
				newWindow=ChoixMode.new
			end
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(diffLabel, 4, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(facile, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(moyen, 4, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(difficile, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 4, 6, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(tableMain)

		show_all
	end
end