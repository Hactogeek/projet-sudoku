require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class ChoixDifficulte < WindowSudoku

	def initialize(invite, examen)
		super("Choix de difficulté")

		#Création du label
		diffLabel = Gtk::Label.new("Difficulté : ")

		#Création des boutons
		facile = Gtk::Button.new(:label => "Facile")
		moyen = Gtk::Button.new(:label => "Moyen")
		difficile = Gtk::Button.new(:label => "Difficile")
		retour = Gtk::Button.new(:label => "Retour")

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
		tableMain.attach(diffLabel, 4, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(facile, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(moyen, 4, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(difficile, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 4, 6, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end