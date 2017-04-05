require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class APropos < WindowSudoku

	def initialize(invite)
		super("A Propos")

		#Création du label
		app = Gtk::Label.new("Application créée par le groupe D dans le cadre du deuxième semestre de la licence 3 Sciences pour Ingénieur.")
		membre = Gtk::Label.new("Voici les participants : ")
		yassine = Gtk::Label.new("Yassine M'Chaar")
		killian = Gtk::Label.new("Kilian Florin")
		leo = Gtk::Label.new("Léo Boisson")
		alexandre = Gtk::Label.new("Alexandre Pradere-Niquet")
		tony = Gtk::Label.new("Tony Marteau")
		remi = Gtk::Label.new("Rémi Bouvet")
		modira = Gtk::Label.new("Modira Mok")

		#Création des boutons
		retour = Gtk::Button.new(:label => "Retour")

		#Redirection des boutons
		retour.signal_connect "clicked" do |widget|
			hide
			if(invite==1)
				newWindow=Invite.new
			else
				newWindow=MenuProfil.new
			end
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(app, 4, 6, 0, 1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(membre, 4, 6, 1, 2, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(yassine, 4, 6, 2, 3, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(killian, 4, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(leo, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(alexandre, 4, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(tony, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(remi, 4, 6, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(modira, 4, 6, 8, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 4, 6, 9, 10, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		
		show_all
	end
end