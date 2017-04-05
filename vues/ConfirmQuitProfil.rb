require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class ConfirmQuitProfil < QuitConfirm

	def initialize(partie, fenetre, destroy)
		super()
		
		#Création du label
		label.set_text("Voulez-vous sauvegarder avant de quitter la partie?")

		#Création du bouton
		retour = Gtk::Button.new(:label => "Retour")

		#Redirection des boutons
		oui.signal_connect "clicked" do |widget|
			partie.stopTemps
			Sauvegarde.savePartie(partie,"partie1")
			if(destroy==1)
				Gtk.main_quit
			else
				hide
				fenetre.hide
				newWindow = MenuProfil.new
			end
		end

		non.signal_connect "clicked" do |widget|
			if(destroy==1)
				Gtk.main_quit
			else
				hide
				fenetre.hide
				newWindow = MenuProfil.new
			end
		end

		retour.signal_connect "clicked" do |widget|
			hide
		end

		tableMain.attach(retour, 3, 5, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end