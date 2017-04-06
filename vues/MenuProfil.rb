require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }



class MenuProfil < WindowSudoku

	def initialize

		super("Menu")

		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 205, :heigth => 200)))

		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)

		#Création du label
		nomJoueur = Gtk::Label.new("Bonjour, " + File.split(Dir.getwd)[-1]+ " !")

		#Création des boutons
		nouvellePartie = Gtk::Button.new(:label => "Nouvelle partie")
		nouvellePartie.override_background_color(:normal, @colorNeutral)
		nouvellePartie.set_size_request(102,50)
		importerGrille = Gtk::Button.new(:label => "Importer grille")
		importerGrille.override_background_color(:normal, @colorNeutral)
		importerGrille.set_size_request(102,50)
		chargerPartie = Gtk::Button.new(:label => "Charger partie")
		chargerPartie.override_background_color(:normal, @colorNeutral)
		chargerPartie.set_size_request(102,50)
		statistique = Gtk::Button.new(:label => "Statistique")
		statistique.override_background_color(:normal, @colorNeutral)
		statistique.set_size_request(102,50)
		parametres = Gtk::Button.new(:label => "Paramètres")
		parametres.override_background_color(:normal, @colorNeutral)
		parametres.set_size_request(102,50)
		methodeRes = Gtk::Button.new(:label => "Méthodes")
		methodeRes.override_background_color(:normal, @colorNeutral)
		methodeRes.set_size_request(102,50)
		deconnexion = Gtk::Button.new(:label => "Deconnexion")
		deconnexion.set_size_request(102,50)
		deconnexion.set_name "deconnexion"


		aPropos = Gtk::Button.new(:label => "A propos")
		aPropos.set_size_request(102,50)

		#Redirection des boutons
		nouvellePartie.signal_connect "clicked" do |widget|
			hide
			newWindow=ChoixMode.new
		end
		importerGrille.signal_connect "clicked" do |widget|
			hide
			newWindow=FenetreImportee.new
		end
		chargerPartie.signal_connect "clicked" do |widget|
			hide
			newWindow=FenetreExamen.new(Partie.nouvelle(3))
			newWindow.chargement
			if(!newWindow.examen?)
				newWindow.hide
				newWindow2=FenetreApprentissage.new(Partie.nouvelle(3))
				newWindow2.chargement
			end
		end
		statistique.signal_connect "clicked" do |widget|
		end
		parametres.signal_connect "clicked" do |widget|
		end
		methodeRes.signal_connect "clicked" do |widget|
			hide
			newWindow=MethodeRes.new(0)
		end
		deconnexion.signal_connect "clicked" do |widget|
			hide
			Dir.chdir("../..")
			newWindow=Index.new
		end
		aPropos.signal_connect "clicked" do |widget|
			hide
			newWindow=APropos.new(0)
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nomJoueur, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(nouvellePartie, 0, 5, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(importerGrille, 0, 5, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(chargerPartie, 5, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(statistique, 5, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(parametres, 0, 5, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(methodeRes, 5, 10, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(deconnexion, 0, 5, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(aPropos, 5, 10, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		if(!File.exist?("partie1.txt"))
			chargerPartie.sensitive = false
		end

		show_all
	end
end