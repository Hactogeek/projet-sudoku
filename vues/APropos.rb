require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class APropos < WindowSudoku

	def initialize(invite)
		super("A Propos")

		begin
			header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 205, :heigth => 200)))
		rescue
			header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/header.png", :width => 205, :heigth => 200)))	
		end	
		

		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 1)

		#Création du label
		app = Gtk::Label.new("  Application créée par le groupe D,\ndans le cadre du deuxième semestre \n       de la licence 3 Sciences pour \n                       l'Ingénieur.\n\n                        Membres :")
		yassine = Gtk::Label.new("Yassine M'Chaar")
		killian = Gtk::Label.new("Kilian Florin")
		leo = Gtk::Label.new("Léo Boisson")
		alexandre = Gtk::Label.new("Alexandre Pradere-Niquet")
		tony = Gtk::Label.new("Tony Marteau")
		remi = Gtk::Label.new("Rémi Bouvet")
		modira = Gtk::Label.new("Modira Mok")

		#Création des boutons
		retour = Gtk::Button.new(:label => "Retour")
		retour.override_background_color(:normal, @colorNeutral)
		retour.set_size_request(205,50)

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
		tableMain.attach(app, 0, 10, 1, 2, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(yassine, 0, 10, 2, 3, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(killian, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(leo, 0, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(alexandre, 0, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(tony, 0, 10, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(remi, 0, 10, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(modira, 0, 10, 8, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 0, 10, 9, 10, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		
		show_all
	end
end