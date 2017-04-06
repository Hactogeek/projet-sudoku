require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class ChoixDifficulte < WindowSudoku

	def initialize(invite, examen)
		super("Choix de difficulté")

		@colorRed   = "#FFc8c8"
		begin
			header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 205, :heigth => 200)))
		rescue
			header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/header.png", :width => 205, :heigth => 200)))
		end
		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)

		#Création du label
		diffLabel = Gtk::Label.new("Difficulté : ")

		#Création des boutons
		facile = Gtk::Button.new(:label => "Facile")
		facile.override_background_color(:normal, @colorNeutral)
		facile.set_size_request(205,50)
		moyen = Gtk::Button.new(:label => "Moyen")
		moyen.override_background_color(:normal, @colorNeutral)
		moyen.set_size_request(205,50)
		difficile = Gtk::Button.new(:label => "Difficile")
		difficile.override_background_color(:normal, @colorNeutral)
		difficile.set_size_request(205,50)
		retour = Gtk::Button.new(:label => "Retour")
		retour.override_background_color(:normal, @colorNeutral)
		retour.set_size_request(205,50)

		#Redirection des boutons
		facile.signal_connect "clicked" do |widget|
			hide
			if(invite==1)
				newWindow=FenetreInvitee.new(Partie.nouvelle(3))
			else
				if(examen==1)
					newWindow=FenetreExamen.new(Partie.nouvelle(3))
				else
					newWindow=FenetreApprentissage.new(Partie.nouvelle(3))
				end
			end
		end
		moyen.signal_connect "clicked" do |widget|
			hide
			if(invite==1)
				newWindow=FenetreInvitee.new(Partie.nouvelle(4))
			else
				if(examen==1)
					newWindow=FenetreExamen.new(Partie.nouvelle(4))
				else
					newWindow=FenetreApprentissage.new(Partie.nouvelle(4))
				end
			end
		end
		difficile.signal_connect "clicked" do |widget|
			hide
			if(invite==1)
				newWindow=FenetreInvitee.new(Partie.nouvelle(5))
			else
				if(examen==1)
					newWindow=FenetreExamen.new(Partie.nouvelle(5))
				else
					newWindow=FenetreApprentissage.new(Partie.nouvelle(5))
				end
			end
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
		tableMain.attach(diffLabel, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(facile, 0, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(moyen, 0, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(difficile, 0, 10, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 0, 10, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end